# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :span do
    name "Sample Task"
    description "Sample description of my task."
    user
    project
    start_at "2013-03-23 20:43:33"
    end_at "2013-03-23 20:43:33"
    hourly_rate 50
    billable true
    invoiced_at "2013-03-23 20:43:33"
    notes "My notes."
  end
end
