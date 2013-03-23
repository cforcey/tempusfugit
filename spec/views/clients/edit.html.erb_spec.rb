require 'spec_helper'

describe "clients/edit" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "MyString",
      :description => "MyString",
      :user_id => 1,
      :hourly_rate => 1,
      :notes => "MyText"
    ))
  end

  it "renders the edit client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", client_path(@client), "post" do
      assert_select "input#client_name[name=?]", "client[name]"
      assert_select "input#client_description[name=?]", "client[description]"
      assert_select "input#client_user_id[name=?]", "client[user_id]"
      assert_select "input#client_hourly_rate[name=?]", "client[hourly_rate]"
      assert_select "textarea#client_notes[name=?]", "client[notes]"
    end
  end
end
