# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :span do
    name "MyString"
    description "MyString"
    user_id 1
    project_id 1
    start_at "2013-03-23 20:43:33"
    end_at "2013-03-23 20:43:33"
    billable false
    invoiced_at "2013-03-23 20:43:33"
    notes "MyText"
  end
end
