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

  scenario "Signing in with an incorrect password" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'bad_password'
    end
    click_button 'Sign in'
    page.should have_content 'Invalid email or password.'
  end

  scenario "Signing in with an incorrect email" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => 'bad_email@bad.com'
      fill_in 'Password', :with => 'secret!!!'
    end
    click_button 'Sign in'
    page.should have_content 'Invalid email or password.'
  end
end