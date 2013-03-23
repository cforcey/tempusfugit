# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    name "Sample Client"
    description "Client description."
    user
    hourly_rate 50
    notes "My notes."
  end
end
