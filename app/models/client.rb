class Client < ActiveRecord::Base
  
  # a client can belong to a user who can read the timesheets for its projects
  belongs_to :user
  belongs_to :contact, class_name: User
  
  # a client has projects which allow it to see reports on the time worked
  # but since projects do not require a client, deleting a client should just
  # nullify that value and not destroy all the time entries
  has_many :projects, :dependent => :nullify
  
  # a client should always have a name that owns it
  validates :user, :name, :presence => true
  validates :name, :uniqueness => {:scope => :user, :case_sensitive => false }
  validates :hourly_rate, presence: true, numericality: {only_integer: true}
  
  # handle blank, extra long, or trailing spaces
  normalize_attributes :name, :description, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :description, :contact_id, :user_id, :hourly_rate, :notes

  # order by name
  scope :order_by_name, -> { order('clients.name ASC') }
  
end
