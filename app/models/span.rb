class Span < ActiveRecord::Base
  
  # a time span should have a project
  belongs_to :project
  
  # a time span should have a user that owns it
  belongs_to :user
  
  # a project should always have a name and a user that owns it
  validates :user, :name, :billable, :start_at, :end_at, :presence => true
  
  # handle blank, extra long, or trailing spaces
  normalize_attributes :name, :description, :with  => [ :strip, :blank, :squish, { :truncate => { :length => 255 } } ]
  
end
