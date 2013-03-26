require 'spec_helper'

describe ReportsController do

  describe "GET 'project_summary'" do
    it "returns http success" do
      get 'project_summary'
      response.should be_success
    end
  end

  describe "GET 'user_project_detail'" do
    it "returns http success" do
      get 'user_project_detail'
      response.should be_success
    end
  end

end
