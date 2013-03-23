require 'spec_helper'

describe "spans/edit" do
  before(:each) do
    @span = assign(:span, stub_model(Span,
      :name => "MyString",
      :description => "MyString",
      :user_id => 1,
      :project_id => 1,
      :billable => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit span form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", span_path(@span), "post" do
      assert_select "input#span_name[name=?]", "span[name]"
      assert_select "input#span_description[name=?]", "span[description]"
      assert_select "input#span_user_id[name=?]", "span[user_id]"
      assert_select "input#span_project_id[name=?]", "span[project_id]"
      assert_select "input#span_billable[name=?]", "span[billable]"
      assert_select "textarea#span_notes[name=?]", "span[notes]"
    end
  end
end
