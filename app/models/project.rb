class Project < ActiveRecord::Base
  
  # a project must belong to a user to scope them for a particular user of the system
  belongs_to :user
  
  # a project may optionally belong to a client to allow them access
  # to read only views
  belongs_to :client
  
  # a project has many time spans which should be deleted when a project is deleted
  has_many :spans, :dependent => :destroy
  
  # a project should always have a name and a user that owns it
  validates :user, :name, :presence => true
  
  # handle blank, extra long, or trailing spaces
  normalize_attributes :name, :description, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]
end
