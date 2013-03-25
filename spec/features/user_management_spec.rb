require 'spec_helper'

feature 'User Management' do

  background do
    @admin = create(:user, :email => 'sample@example.com', :password => 'secret!!!' )
    sign_in_with_user(@admin)
  end

  scenario 'See a list of users' do
    visit root_path
    click_link 'Users'
    page.should have_content 'Users'
    page.should have_content 'sample@example.com'
  end

  scenario 'Create a new user' do
    visit root_path
    click_link 'Users'
    click_link 'New User'
    within('form.simple_form') do
      fill_in 'Email', :with => 'new_user@example.com'
      fill_in 'First', :with => 'New_first_name'
      fill_in 'Last', :with => 'New_last_name'
      fill_in 'Hourly rate', :with => '99'
      fill_in 'Message', :with => 'New_invoice_message'
      fill_in 'Organization', :with => 'New_organization'
      select('(GMT-06:00) Central Time (US & Canada)', :from => 'Time zone')
      check 'Timekeeper'
      fill_in 'user_password', :with => 'new_secret!!!'
      fill_in 'user_password_confirmation', :with => 'new_secret!!!'
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
    page.should have_content 'Central Time (US & Canada)'
  end

  scenario 'Edit user as admin' do
    visit root_path
    click_link 'Users'
    click_link "user_edit_#{@admin.id}"
    within('form.simple_form') do
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

  scenario 'Destroy a user' do
    @other_user = create(:user)
    visit root_path
    click_link 'Users'
    click_link "user_destroy_#{@other_user.id}"
    page.should have_content 'Users'
    page.should_not have_content @other_user.email
    page.should have_content 'User was successfully deleted.'
  end

  scenario 'Change own password successfully as admin' do
    visit root_path
    click_link 'Profile'
    within('form.simple_form') do
      fill_in 'user_current_password', :with => 'secret!!!'
      fill_in 'user_password', :with => 'new_secret'
      fill_in 'user_password_confirmation', :with => 'new_secret'
    end
    click_button 'Update Profile'
    page.should have_content 'You updated your account successfully.'
  end

  scenario 'Change own password unsuccessfully because of bad current password' do
    visit root_path
    click_link 'Profile'
    within('form.simple_form') do
      fill_in 'user_current_password', :with => 'bad_password'
      fill_in 'user_password', :with => 'new_secret'
      fill_in 'user_password_confirmation', :with => 'new_secret'
    end
    click_button 'Update Profile'
    page.should have_content 'Current passwordis invalid'
  end

end
