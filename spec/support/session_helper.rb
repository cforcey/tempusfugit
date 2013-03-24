# session helps defined as a module
module Features
  module SessionHelpers
    def sign_up_with(first, last, email, password)
      visit users_new_path
      fill_in 'First', with: first
      fill_in 'Last', with: last
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password Confirmation', with: password
      click_button 'Create User'
    end

    def sign_in
      user = create(:user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    def sign_in_with_email_and_password(email = 'sample@example.com', password = "secret!!!")
      user = create(:user, :email => email, :password => password)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    def sign_in_with_user(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
  end
end

# help with the feature testing by loading some helpers
RSpec.configure do |config|
  config.include Features::SessionHelpers, :type => :feature
end