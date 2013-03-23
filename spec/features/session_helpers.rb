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
      visit new_user_session
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
  end
end