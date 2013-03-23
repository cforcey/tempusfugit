# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyString"
    description "MyString"
    user_id 1
    client_id 1
    hourly_rate 1
    notes "MyText"
  end
end
