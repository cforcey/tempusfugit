class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :token_authenticatable

         # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :roles, :first, :middle, :last, :organization, :message, :hourly_rate
  
  # Canard defines roles in order from least to most powerful
  acts_as_user :roles => [:timekeeper, :admin] if ActiveRecord::Base.connected?

  # require that at least one role be set
  validates :roles_mask, :presence => true
  # validate that first and last names are provided
  validates :last, :first, :presence => true
  # validate that emails are unique
  validates :email, :presence => true, :uniqueness => true
  
  # handle blank, extra long, or trailing spaces
  normalize_attributes :first, :middle, :last, :message, :email, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]
  
  # a user has time spans that they have worked
  has_many :spans, :dependent => :destroy
  
  # a user has projects and, through them, clients
  has_many :projects, :dependent => :destroy
  has_many :clients, :through => :projects

  # set an attribute for the current user so we can guarantee they do not delete themselves
  attr_accessor :current_user

  # be sure a user does not every destroy their own currently logged in account
  before_destroy :validates_not_self

  # pretty printing of roles from symbol hash
  def roles_list
    return roles.map { |k| k.to_s.humanize }.sort.to_sentence
  end

  private

  # a custom validation to prevent an admin from ever deleting themselves
  # controller must set the current user in the method, and it must be set
  # and different from the user being deleting for this to work
  # sometimes this is done in the controller, but REST API access in the future
  # may make such controls hard to guarantee.
  def validates_not_self
    if current_user.blank?
      errors.add :base, "Sorry, cannot determine the current user."
      false
    elsif current_user.id == id
      errors.add :base, "Sorry, you cannot delete your own user account."
      false
    end
  end
  
end
