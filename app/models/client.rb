class Client < ActiveRecord::Base
  
  # a client can belong to a user who can read the timesheets for its projects
  belongs_to :user
  
  # a client has projects which allow it to see reports on the time worked
  # but since projects do not require a client, deleting a client should just
  # nullify that value and not destroy all the time entries
  has_many :projects, :dependent => :nullify
  
  # a project should always have a name that owns it
  validates :name, :presence => true
  
  # handle blank, extra long, or trailing spaces
  normalize_attributes :name, :description, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]
  
end
