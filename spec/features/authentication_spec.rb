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

  scenario "Signing in with an incorrect password should fail" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'bad_password'
    end
    click_button 'Sign in'
    page.should have_content 'Invalid email or password.'
  end

  scenario "Signing in with an incorrect email should fail" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => 'bad_email@bad.com'
      fill_in 'Password', :with => 'secret!!!'
    end
    click_button 'Sign in'
    page.should have_content 'Invalid email or password.'
  end

  scenario "Signing out" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'secret!!!'
    end
    click_button 'Sign in'
    page.should have_content 'Signed in successfully.'
    click_link 'Sign out'
    page.should have_content 'Signed out successfully.'
    page.should_not have_content 'Profile'
  end
end