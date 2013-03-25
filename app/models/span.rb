class Span < ActiveRecord::Base

  # a time span should have a project
  belongs_to :project

  # a time span should have a user that owns it
  belongs_to :user

  # a project should always have a name and a user that owns it
  validates :user, :name, :billable, :start_at, :hourly_rate, :end_at, :presence => true

  # make sure the hourly rate is an integer
  validates :hourly_rate, presence: true, numericality: {only_integer: true}

  validate :time_span_unique

  # handle blank, extra long, or trailing spaces
  normalize_attributes :name, :description, :with => [:strip, :blank, :squish, {:truncate => {:length => 255}}]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :description, :user_id, :project_id, :start_at, :end_at, :start_input, :end_input, :billable, :invoiced_at, :notes

  # Time is so important to this application that we needed something better than a picker;
  # This is an experimental use of chronic to parse the dates
  attr_accessor :start_input, :end_input

  # Order scope by start_at time
  scope :order_by_start_at, -> { order('spans.start_at DESC') }

  # Order scope by name
  scope :order_by_name, -> { order('spans.name ASC') }

  # Find spans between two time values
  scope :occurs_between, lambda { |start_time, end_time|
    where('spans.start_at >= :start OR spans.start_at <= :end OR spans.end_at >= :start OR spans.end_at <= :end', start: start_time, end: end_time)
  }

  # Returns all spans except for span_id
  scope :excluding, lambda { |span_id|
    where('spans.id <> :span_id', span_id: span_id)
  }

  # Returns all spans for the current user
  scope :for_user_id, lambda { |user_id|
    where(user_id: user_id)
  }

  def start_input=(value)
    @start_input = value
    self.start_at = Chronic.parse(value)
  end

  def end_input=(value)
    @end_input = value
    self.end_at = Chronic.parse(value)
  end

  private

  # a special validator -- kept with the model as a best practice --
  # so that spans can have a guaranteed unique time period scoped
  # by user.
  def time_span_unique
    if self.start_at.present? && self.end_at.present?
      # limit the search to the same user's span
      spans = Span.for_user_id(self.user_id).occurs_between(self.start_at, self.end_at)
      spans = spans.excluding(self.id) unless self.new_record?
      if spans.count > 0
          self.errors.add(:start_at, I18n.translate('errors.messages.overlaps'))
          self.errors.add(:end_at, I18n.translate('errors.messages.overlaps'))
      end
    end
  end

end
