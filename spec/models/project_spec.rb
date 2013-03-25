require 'spec_helper'

describe Project do

  # be sure the factory is valid
  it 'has a valid factory' do
    create(:project).should be_valid
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
    context 'if project with name "Sample Project" exists' do

      before do
        @project = create(:project, :name => 'Sample Project')
      end

      it 'should not accept a project for the same user with the same name' do
        @new_project = build(:project, user: @project.user, name: 'Sample Project')
        @new_project.should_not be_valid
      end

      it 'should not accept a project for the same user with the same name lower case' do
        @new_project = build(:project, user: @project.user, name: 'sample project')
        @new_project.should_not be_valid
      end

      # but if the users are different, go right ahead and use the same name
      it { should accept_values_for(:name, 'Sample Project') }
      it { should accept_values_for(:name, 'sample project') }
    end
  end

  # test the named scopes for ordering and searching
  describe 'when a project is searched or sorted' do

    before :each do
      @project1 = create(:project, name: 'Apple Picking')
      @project2 = create(:project, name: 'Zebra Ranching')
      @project3 = create(:project, name: 'Banana Picking')
    end

    it 'should be listed in ascending name order' do
      @projects = Project.order_by_name
      @projects.first.should == @project1
      @projects.last.should == @project2
    end

  end

end