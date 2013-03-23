# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create an initial administrator to kick things off
a = User.where(:email => 'admin@example.com').first_or_create(:password => '@dminister', 
  :password_confirmation => '@dminister', 
  :roles => ['admin'],
  :first => 'Default',
  :last => 'Administrator'  )
if a.errors.present?
  puts a.errors.inspect 
else
  puts "Created or reset initial user admin@example.com to password of '@administer'."
end  