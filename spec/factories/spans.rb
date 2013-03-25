# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :span do
    name 'Sample Task'
    description 'Sample description of my task.'
    user
    project
    start_at { Random.date }
    end_at { start_at + 10.minutes }
    hourly_rate 50
    billable true
    invoiced_at { start_at + 2.days }
    notes 'My notes.'
  end
end
