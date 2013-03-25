require_relative '../spec_helper'

require "cancan/matchers"

describe Canard::Abilities, "for users" do

  before do
    @user = create(:user, roles: [])
  end
  
  subject { Ability.new(@user) }
  
    
  describe 'on User' do

    before do
      @user = create(:user)
    end
    
    it { should be_able_to( :edit, @user ) }

  end
  # on User
    
  
end
  
