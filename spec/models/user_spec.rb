require 'spec_helper'

describe User do

  # be sure the factory is valid
  it 'has a valid factory' do
    create(:user).should be_valid
  end

  describe 'should validate' do
    # test the standard normalization of attributes
    it { should normalize_attribute(:first)  }
    it { should normalize_attribute(:middle) }
    it { should normalize_attribute(:last) }
    it { should normalize_attribute(:message) }
    it { should normalize_attribute(:email) }

    # test validations
    it { should_not accept_values_for(:roles_mask, nil, 'abc', 1.345) }
    it { should_not accept_values_for(:last, nil) }
    it { should_not accept_values_for(:first, nil) }
    it { should_not accept_values_for(:time_zone, nil, 'Not A Real Zone') }
    it { should_not accept_values_for(:hourly_rate, nil, 'abc', 1.345) }


    # uniqueness is a special validation because you need
    # more then one record to test it. So, the pattern
    # for uniqueness validation is:                                                                                                                            describe User do
    context 'if user with email "aa@bb.com" exists' do
      before do
        create(:user, :email => 'aa@bb.com')
      end
      it { should_not accept_values_for(:email, 'aa@bb.com') }
    end
  end

  describe 'should provide instance methods that' do
    before :each do
      @jane_smith = create(:user, last: 'Smith', first: 'Jane', roles: %w(timekeeper))
      @bob_carl_smith = create(:user, last: 'Smith', first: 'Bob', middle: 'Carl', roles: %w(timekeeper admin))
    end

    it 'returns a contact full name as a string' do
      @jane_smith.name.should == 'Jane Smith'
      @bob_carl_smith.name.should == 'Bob Carl Smith'
    end

    it 'returns a sortable name as a string' do
      @jane_smith.sort_name.should == 'Smith, Jane'
      @bob_carl_smith.sort_name.should == 'Smith, Bob Carl'
    end

    it 'returns humanized roles in a sorted sentence' do
      @jane_smith.roles_list.should == 'Timekeeper'
      @bob_carl_smith.roles_list.should == 'Admin and Timekeeper'
    end
  end

  # test the after create hooks that guarantee things like the existence
  # of a default project for every new user
  describe 'when a user is created' do

    before :each do
      @jane_smith = create(:user)
    end

    it 'should have a default project' do
      @jane_smith.projects.count.should == 1
    end

  end

  # test the named scopes for ordering and searching
  describe 'when a user is searched or sorted' do

    before :each do
      @jane_smith = create(:user, last: 'Smith', first: 'Jane', roles: %w(timekeeper))
      @bob_carl_smith = create(:user, last: 'Smith', first: 'Bob', middle: 'Carl', roles: %w(timekeeper admin))
      @georges_santayana = create(:user, last: 'Santayana', first: 'Georges', roles: %w(timekeeper admin))
    end

    it 'should be listed in last, first, middle order' do
      @users = User.order_by_sort_name
      @users.first.should == @georges_santayana
      @users.last.should == @jane_smith
    end

  end

  # test the special case of a user deleting themselves.  We
  # can't log in or have the full stack (see related feature test)
  # but we coded this protection in the model based on the value
  # of current_use
  describe 'when a user is deleted' do

    before do
      @admin = create(:user)
      @user_to_delete = create(:user)
    end

    it 'should allow deletion if current user is known and not the same' do
      @user_to_delete.passed_current_user = @admin
      lambda { @user_to_delete.destroy }.should change(User, :count).by(-1)
    end

    it 'should prevent deletion if current user is unknown' do
      lambda { @user_to_delete.destroy }.should_not change(User, :count).by(-1)
    end

    it 'should prevent deletion if current user is known and the same' do
      @user_to_delete.passed_current_user = @user_to_delete
      lambda { @user_to_delete.destroy }.should_not change(User, :count).by(-1)
    end

  end

end
