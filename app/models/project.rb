class Project < ActiveRecord::Base

  # a project must belong to a user to scope them for a particular user of the system
  belongs_to :user

  # a project may optionally belong to a client to allow them access
  # to read only views
  belongs_to :client

  # a project has many time spans which should prevent its deletion (see validation)
  has_many :spans

  # a project should always have a name and a user that owns it
  validates :user, :name, :presence => true
  validates :name, :uniqueness => {:scope => :user, :case_sensitive => false }
  validates :hourly_rate, presence: true, numericality: {only_integer: true}

  # handle blank, extra long, or trailing spaces
  normalize_attributes :name, :description, :with => [:strip, :blank, :squish, {:truncate => {:length => 255}}]

  # scope in name order
  scope :order_by_name, -> { order('projects.name ASC') }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :description, :user_id, :client_id, :hourly_rate, :notes

  # be sure a user does not every destroy their own currently logged in account
  before_destroy :validates_not_last, :validates_no_more_spans


  private

  # we always need at least one project
  def validates_not_last
    errors.add :base, I18n.translate('errors.messages.cannot_delete_last') if Project.count == 1
  end

  # block deletion is there are still spans assigned
  def validates_no_more_spans
    errors.add :base, I18n.translate('errors.messages.cannot_delete_with_spans') if self.spans.count > 1
  end

end
