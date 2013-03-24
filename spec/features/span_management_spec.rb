require 'spec_helper'

feature "Span Management" do

  background do
    @admin = create(:user, :email => 'sample@example.com', :password => 'secret!!!' )
    sign_in_with_user(@admin)
    @span = create(:span, :user => @admin)
  end

  scenario "See a list of spans for current user" do
    visit root_path
    click_link 'Spans'
    page.should have_content 'Listing spans'
    page.should have_content @span.name
  end

  scenario "Create a new span" do
    pending "inline creation code"
    visit root_path
    click_link 'Spans'
    click_link 'New Span'
    within("form.simple_form") do
      fill_in 'Email', :with => 'new_span@example.com'
      fill_in 'First', :with => 'New_first_name'
      fill_in 'Last', :with => 'New_last_name'
      fill_in 'Hourly rate', :with => '99'
      fill_in 'Message', :with => 'New_invoice_message'
      fill_in 'Organization', :with => 'New_organization'
      check 'Timekeeper'
      fill_in 'span_password', :with => 'new_secret!!!'
      fill_in 'span_password_confirmation', :with => 'new_secret!!!'
    end
    click_button 'Update Span'
    page.should have_content 'Span was successfully created.'
    page.should have_content 'new_span@example.com'
    page.should have_content 'New_first_name'
    page.should have_content 'New_last_name'
    page.should have_content '99'
    page.should have_content 'New_invoice_message'
    page.should have_content 'New_organization'
    page.should have_content 'Timekeeper'
  end

  scenario "Edit span as admin" do
    pending "best_in_place editing code"
    visit root_path
    click_link 'Spans'
    click_link "span_edit_#{@admin.id}"
    within("form.simple_form") do
      fill_in 'First', :with => 'New_first_name'
      fill_in 'Last', :with => 'New_last_name'
      fill_in 'Hourly rate', :with => '99'
      fill_in 'Message', :with => 'New_invoice_message'
      fill_in 'Organization', :with => 'New_organization'
      check 'Timekeeper'
    end
    click_button 'Update Span'
    page.should have_content 'Span was successfully updated.'
    page.should have_content 'New_first_name'
    page.should have_content 'New_last_name'
    page.should have_content '99'
    page.should have_content 'New_invoice_message'
    page.should have_content 'New_organization'
    page.should have_content 'Timekeeper'
  end

  scenario "Destroy a span" do
    @other_span = create(:span, :name => 'To Be Deleted')
    visit root_path
    click_link 'Spans'
    click_link "span_destroy_#{@other_span.id}"
    page.should have_content 'Listing spans'
    page.should_not have_content @other_span.name
    page.should have_content 'Span was successfully deleted.'
  end

end
