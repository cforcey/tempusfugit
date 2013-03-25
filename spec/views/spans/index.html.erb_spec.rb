require 'spec_helper'

describe 'spans/index' do
  before(:each) do
    assign(:spans, [
      stub_model(Span,
        :name => 'Name',
        :description => 'Description',
        :user_id => 1,
        :project_id => 2,
        :billable => false,
        :notes => 'MyText'
      ),
      stub_model(Span,
        :name => 'Name',
        :description => 'Description',
        :user_id => 1,
        :project_id => 2,
        :billable => false,
        :notes => 'MyText'
      )
    ])
  end

  it 'renders a list of spans' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', :text => 'Name'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Description'.to_s, :count => 2
    assert_select 'tr>td', :text => 1.to_s, :count => 2
    assert_select 'tr>td', :text => 2.to_s, :count => 2
    assert_select 'tr>td', :text => false.to_s, :count => 2
    assert_select 'tr>td', :text => 'MyText'.to_s, :count => 2
  end
end
