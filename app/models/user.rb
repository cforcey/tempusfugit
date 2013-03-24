class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :roles, :first, :middle, :last, :organization, :message, :hourly_rate
  
  # Canard defines roles in order from least to most powerful
  acts_as_user :roles => [:timekeeper, :admin] if ActiveRecord::Base.connected?

  # require that at least one role be set
  validates :roles_mask, :presence => true
  # validate that first and last names are provided
  validates :last, :first, :presence => true
  
  # handle blank, extra long, or trailing spaces
  normalize_attributes :first, :middle, :last, :message, :email, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]
  
  # a user has time spans that they have worked
  has_many :spans, :dependent => :destroy
  
  # a user has projects and, through them, clients
  has_many :projects, :dependent => :destroy
  has_many :clients, :through => :projects

  # pretty printing of roles from symbol hash
  def roles_list
    return roles.map { |k| k.to_s.humanize }.sort.to_sentence
  end
  
end
