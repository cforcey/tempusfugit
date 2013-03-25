require 'spec_helper'

describe Client do

  # be sure the factory is valid
  it 'has a valid factory' do
    create(:client).should be_valid
  end

  describe 'should validate' do

    # test the standard normalization of attributes
    it { should normalize_attribute(:name) }
    it { should normalize_attribute(:description) }

    # test validations
    it { should_not accept_values_for(:name, nil) }
    it { should_not accept_values_for(:user, nil) }
    it { should_not accept_values_for(:hourly_rate, nil, 'hello', 3.4) }

    # uniqueness is a special validation because you need
    # more then one record to test it. So, the pattern
    # for uniqueness validation is:                                                                                                                            describe User do
    context 'if client with name "Sample Client" exists' do

      before do
        @client = create(:client, :name => 'Sample Client')
      end

      it 'should not accept a client for the same user with the same name' do
        @new_client = build(:client, user: @client.user, name: 'Sample Client')
        @new_client.should_not be_valid
      end

      it 'should not accept a client for the same user with the same name lower case' do
        @new_client = build(:client, user: @client.user, name: 'sample client')
        @new_client.should_not be_valid
      end

      # but if the users are different, go right ahead and use the same name
      it { should accept_values_for(:name, 'Sample Client') }
      it { should accept_values_for(:name, 'sample client') }
    end
  end

  # test the named scopes for ordering and searching
  describe 'when a client is searched or sorted' do

    before :each do
      @client1 = create(:client, name: 'Apple Picking')
      @client2 = create(:client, name: 'Zebra Ranching')
      @client3 = create(:client, name: 'Banana Picking')
    end

    it 'should be listed in ascending name order' do
      @clients = Client.order_by_name
      @clients.first.should == @client1
      @clients.last.should == @client2
    end

  end

end