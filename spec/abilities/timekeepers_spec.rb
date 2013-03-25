require_relative '../spec_helper'

require "cancan/matchers"

describe Canard::Abilities, "for timekeepers" do

  before do
    @user = create(:user, roles:[%w(timekeeper)])
  end
  
  subject { Ability.new(@user) }
  
    
  describe 'on Client' do

    before do
      @client = create(:client)
    end
    
    it { should be_able_to( :manage,    @client ) }

  end
  # on Client
      
  describe 'on Project' do

    before do
      @project = create(:project)
    end
    
    it { should be_able_to( :manage,    @project ) }

  end
  # on Project
      
  describe 'on Span' do

    before do
      @span = create(:span)
    end
    
    it { should be_able_to( :manage,    @span ) }

  end
  # on Span
    
  
end
  
