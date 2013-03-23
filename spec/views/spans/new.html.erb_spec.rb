require 'spec_helper'

describe "spans/new" do
  before(:each) do
    assign(:span, stub_model(Span,
      :name => "MyString",
      :description => "MyString",
      :user_id => 1,
      :project_id => 1,
      :billable => false,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new span form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spans_path, "post" do
      assert_select "input#span_name[name=?]", "span[name]"
      assert_select "input#span_description[name=?]", "span[description]"
      assert_select "input#span_user_id[name=?]", "span[user_id]"
      assert_select "input#span_project_id[name=?]", "span[project_id]"
      assert_select "input#span_billable[name=?]", "span[billable]"
      assert_select "textarea#span_notes[name=?]", "span[notes]"
    end
  end
end
