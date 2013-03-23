require 'spec_helper'

describe "spans/show" do
  before(:each) do
    @span = assign(:span, stub_model(Span,
      :name => "Name",
      :description => "Description",
      :user_id => 1,
      :project_id => 2,
      :billable => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
  end
end
