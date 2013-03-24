require 'spec_helper'

feature "User Management" do
  background do
    sign_in_with('sample@example.com','secret!!!')
  end

  scenario "Create a new user" do
    visit root_path
    click_link 'Users'
    click_link 'New User'
    within("form.simple_form") do
      fill_in 'Email', :with => 'new_user@example.com'
      fill_in 'First', :with => 'New_first_name'
      fill_in 'Last', :with => 'New_last_name'
      fill_in 'Hourly rate', :with => '99'
      fill_in 'Message', :with => 'New_invoice_message'
      fill_in 'Organization', :with => 'New_organization'
      check 'Timekeeper'
    end
    click_button 'Update User'
    page.should have_content 'User was successfully created.'
    page.should have_content 'new_user@example.com'
    page.should have_content 'New_first_name'
    page.should have_content 'New_last_name'
    page.should have_content '99'
    page.should have_content 'New_invoice_message'
    page.should have_content 'New_organization'
    page.should have_content 'Timekeeper'
  end

  scenario "Edit user profile" do
    visit root_path
    click_link 'Profile'
    click_link 'Edit'
    within("form.simple_form") do
      fill_in 'First', :with => 'New_first_name'
      fill_in 'Last', :with => 'New_last_name'
      fill_in 'Hourly rate', :with => '99'
      fill_in 'Message', :with => 'New_invoice_message'
      fill_in 'Organization', :with => 'New_organization'
      check 'Timekeeper'
    end
    click_button 'Update User'
    page.should have_content 'User was successfully updated.'
    page.should have_content 'New_first_name'
    page.should have_content 'New_last_name'
    page.should have_content '99'
    page.should have_content 'New_invoice_message'
    page.should have_content 'New_organization'
    page.should have_content 'Timekeeper'
  end

  scenario "Change user password successfully" do
    visit root_path
    click_link 'Profile'
    click_link 'Change Password'
    within("form.simple_form") do
      fill_in 'user_current_password', :with => 'secret!!!'
      fill_in 'user_password', :with => 'new_secret'
      fill_in 'user_password_confirmation', :with => 'new_secret'
    end
    click_button 'Update Password'
    page.should have_content 'You updated your account successfully.'
  end

  scenario "Change user password unsuccessfully because of bad current password" do
    visit root_path
    click_link 'Profile'
    click_link 'Change Password'
    within("form.simple_form") do
      fill_in 'user_current_password', :with => 'bad_password'
      fill_in 'user_password', :with => 'new_secret'
      fill_in 'user_password_confirmation', :with => 'new_secret'
    end
    click_button 'Update Password'
    page.should have_content 'Current passwordis invalid'
  end

end