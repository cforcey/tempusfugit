# require capybara
require 'capybara/rspec'

# switch the default Capybara driver from selenium
# Capybara.current_driver = :webkit # temporarily select different driver

# help with the feature testing by loading some helpers
# RSpec.configure do |config|
  # config.include Features::SessionHelpers, type: :feature
# end