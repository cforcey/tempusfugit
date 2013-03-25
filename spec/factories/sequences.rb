# Defines an email sequence
FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

end