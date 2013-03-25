# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name 'Sample Project'
    description 'Sample project description.'
    user
    client
    hourly_rate 75
    notes 'My notes.'
  end
end
