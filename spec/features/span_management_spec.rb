require 'spec_helper'

feature 'Span Management' do

  background do
    @admin = create(:user, email: 'sample@example.com', password: 'secret!!!', roles: %w(timekeeper admin))
    sign_in_with_user(@admin)
    @span = create(:span, :user => @admin)
  end

  scenario 'See a list of spans for current user' do
    visit root_path
    click_link 'Spans'
    page.should have_content 'Spans'
    page.should have_content @span.name
  end

  scenario 'Create a new span' do
    visit root_path
    click_link 'Spans'
    within('form.simple_form') do
      fill_in 'span_name', :with => 'Span Test'
      fill_in 'span_start_input', :with => '10 am'
      fill_in 'span_end_input', :with => '11 am'
    end
    click_button 'Add Span'
    page.should have_content 'Span Test'
    page.should have_content '10:00 am'
    page.should have_content '11:00 am'
  end

  scenario 'Edit span as admin' do
    visit root_path
    click_link 'Spans'
    click_link "span_edit_#{@span.id}"
    within('form.simple_form') do
      fill_in 'Name', :with => 'New_Name'
      fill_in 'Description', :with => 'New_Description'
    end
    click_button 'Update Span'
    page.should have_content 'Span was successfully updated.'
    page.should have_content 'New_Name'
  end

  scenario 'Destroy a span' do
    @other_span = create(:span, :name => 'To Be Deleted', :user => @admin)
    visit root_path
    click_link 'Spans'
    click_link "span_destroy_#{@other_span.id}"
    page.should have_content 'Spans'
    page.should_not have_content @other_span.name
    page.should have_content 'Span was successfully deleted.'
  end

end
