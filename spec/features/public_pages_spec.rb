require 'spec_helper'

feature "Public pages should be accessible" do

  scenario "Should be able to see the home page" do
    visit root_path
    page.should have_content 'Welcome'
  end

  scenario "Should be able to see the about page" do
    visit about_path
    page.should have_content 'About'
  end

  scenario "Should be able to see the contact page" do
    visit contact_path
    page.should have_content 'Contact'
  end

  scenario "Should be able to see the terms page" do
    visit terms_path
    page.should have_content 'Terms'
  end

  scenario "Should be able to see the faq page" do
    visit faq_path
    page.should have_content 'Frequently Asked Questions'
  end

  scenario "Should be able to see the tour page" do
    visit tour_path
    page.should have_content 'Tour'
  end

end