# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first "Jane"
    last "Smith"
    email
    hourly_rate 45
    password "secret!!!"
    password_confirmation "secret!!!"
    roles ["admin"]
  end
end
