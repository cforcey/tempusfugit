require 'spec_helper'

describe "clients/new" do
  before(:each) do
    assign(:client, stub_model(Client,
      :name => "MyString",
      :description => "MyString",
      :user_id => 1,
      :hourly_rate => 1,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", clients_path, "post" do
      assert_select "input#client_name[name=?]", "client[name]"
      assert_select "input#client_description[name=?]", "client[description]"
      assert_select "input#client_user_id[name=?]", "client[user_id]"
      assert_select "input#client_hourly_rate[name=?]", "client[hourly_rate]"
      assert_select "textarea#client_notes[name=?]", "client[notes]"
    end
  end
end
