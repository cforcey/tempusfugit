require 'spec_helper'

describe 'Users' do
  describe 'GET /users' do
    it 'works! (now write some real specs)' do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get admin_users_path
      response.status.should be(200)
    end

    # because there is no link in the interface for destroying
    # one's own account, we have to switch to a direct RackTest
    # destroy call to test that this bad behavior is blocked.
    it 'should fail to destroy own user account', :type => :api do
      pending 'request spec setup with signin'
      @current_user = FactoryGirl.create(:user)
      sign_in_with_user(@current_user)
      delete "/users/#{@current_user.id}"
      page.should have_content 'Listing users'
      page.should have_content 'Sorry, you cannot delete your own user account.'
    end
  end
end
