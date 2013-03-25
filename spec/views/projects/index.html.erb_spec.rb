require 'spec_helper'

describe 'projects/index' do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :name => 'Name',
        :description => 'Description',
        :user_id => 1,
        :client_id => 2,
        :hourly_rate => 3,
        :notes => 'MyText'
      ),
      stub_model(Project,
        :name => 'Name',
        :description => 'Description',
        :user_id => 1,
        :client_id => 2,
        :hourly_rate => 3,
        :notes => 'MyText'
      )
    ])
  end

  it 'renders a list of projects' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', :text => 'Name'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Description'.to_s, :count => 2
    assert_select 'tr>td', :text => 1.to_s, :count => 2
    assert_select 'tr>td', :text => 2.to_s, :count => 2
    assert_select 'tr>td', :text => 3.to_s, :count => 2
    assert_select 'tr>td', :text => 'MyText'.to_s, :count => 2
  end
end
