require 'spec_helper'

describe 'projects/new' do
  before(:each) do
    assign(:project, stub_model(Project,
      :name => 'MyString',
      :description => 'MyString',
      :user_id => 1,
      :client_id => 1,
      :hourly_rate => 1,
      :notes => 'MyText'
    ).as_new_record)
  end

  it 'renders new project form' do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'form[action=?][method=?]', projects_path, 'post' do
      assert_select 'input#project_name[name=?]', 'project[name]'
      assert_select 'input#project_description[name=?]', 'project[description]'
      assert_select 'input#project_user_id[name=?]', 'project[user_id]'
      assert_select 'input#project_client_id[name=?]', 'project[client_id]'
      assert_select 'input#project_hourly_rate[name=?]', 'project[hourly_rate]'
      assert_select 'textarea#project_notes[name=?]', 'project[notes]'
    end
  end
end
