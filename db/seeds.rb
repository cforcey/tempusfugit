# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create an initial administrator to kick things off
u = User.where(:email => 'admin@example.com').first_or_create(:password => '@dminister',
                                                              :password_confirmation => 'password',
                                                              :roles => ['admin'],
                                                              :first => 'Default',
                                                              :last => 'Administrator',
                                                              :time_zone => 'Eastern Time (US & Canada)')

if u.errors.present?
  puts "There was an error saving the user: \n" + u.errors.inspect
else
  puts "Created or reset initial user admin@example.com to password of 'password'."
end

# TODO: create a sample client and other nice instructive information
# TODO: create some sample spans so the reports and everything look nice and normal