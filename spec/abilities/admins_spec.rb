require_relative '../spec_helper'

require "cancan/matchers"

describe Canard::Abilities, "for admins" do

  before do
    @user = create(:user, roles:%w(admin))
  end
  
  subject { Ability.new(@user) }
  
    
  describe 'on User' do

    before do
      @user = create(:user)
    end
    
    it { should be_able_to( :manage,    @user ) }

  end
  # on User
    
  
end
  
