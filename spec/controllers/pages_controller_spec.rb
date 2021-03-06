require 'spec_helper'

describe PagesController do

  describe "GET 'welcome'" do
    it 'returns http success' do
      get 'welcome'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it 'returns http success' do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it 'returns http success' do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'faq'" do
    it 'returns http success' do
      get 'faq'
      response.should be_success
    end
  end

end
