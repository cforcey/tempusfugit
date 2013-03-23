require 'spec_helper'

feature "Authentication" do
  background do
    create(:user, :email => 'user@example.com', :password => 'secret!!!')
  end

  scenario "Signing in with correct credentials" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'secret!!!'
    end
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'
  end

  given(:other_user) { create(:user, :email => 'other@example.com', :password => 'othersecret!!!') }

  scenario "Signing in as another user with incorrect password" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => other_user.email
      fill_in 'Password', :with => 'bad_password'
    end
    click_button 'Sign in'
    page.should have_content 'Invalid email or password.'
  end
end