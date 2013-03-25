class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :roles, :first, :middle, :last, :organization, :message, :hourly_rate, :time_zone
  
  # Canard defines roles in order from least to most powerful
  acts_as_user :roles => [:timekeeper, :admin] if ActiveRecord::Base.connected?

  # validate that first and last names are provided and at least one role be set
  validates :roles_mask, presence: true, numericality: {only_integer: true}
  validates :last, :first, presence: true
  validates :hourly_rate, presence: true, numericality: {only_integer: true}
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name) }
  # Note: devise takes care of validating emails are unique, formatted, confirmed, truncated

  # handle blank, extra long, or trailing spaces
  normalize_attributes :first, :middle, :last, :message, :email, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]
  
  # a user has time spans that they have worked
  has_many :spans, :dependent => :destroy
  
  # a user has projects and, through them, clients
  has_many :projects, :dependent => :destroy
  has_many :clients, :through => :projects

  # set an attribute for the current user so we can guarantee they do not delete themselves
  attr_accessor :passed_current_user

  # be sure a user does not every destroy their own currently logged in account
  before_destroy :validates_not_self

  # after creation, set up a default project since every span needs a project
  after_create :create_default_project

  # scope to sort by last, first, middle
  scope :order_by_sort_name, -> { order('users.last, users.first, users.middle') }

  # pretty printing of roles from symbol hash
  def roles_list
    roles.map { |k| k.to_s.humanize }.sort.to_sentence
  end

  # name attribute from first and last
  def name
    output = []
    output << self.first unless self.first.blank?
    output << self.middle unless self.middle.blank?
    output << self.last unless self.last.blank?
    output.join(' ')
  end

  # name attribute from first and last
  def sort_name
    output = []
    output << self.last unless self.last.blank?
    output << self.first unless self.first.blank?
    output = [output.join(', ')]
    output << self.middle unless self.middle.blank?
    output.join(' ')
  end

  private

  # a custom validation to prevent an admin from ever deleting themselves
  # controller must set the current user in the method, and it must be set
  # and different from the user being deleting for this to work
  # sometimes this is done in the controller, but REST API access in the future
  # may make such controls hard to guarantee.
  def validates_not_self
    if passed_current_user.blank?
      errors.add :base, I18n.translate('errors.messages.current_user_unknown')
      false
    elsif passed_current_user.id == self.id
      errors.add :base, I18n.translate('errors.messages.current_user_cannot_delete_self')
      false
    end
  end

  # when a user has been created, we need to ensure that they have a default project
  def create_default_project
    self.projects.create(:name => 'Default Project')
  end
  
end
