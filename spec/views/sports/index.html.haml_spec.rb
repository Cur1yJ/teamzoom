require 'spec_helper'

describe "sports/index" do
  before(:each) do
    assign(:sports, [
      stub_model(Sport,
        :name => "Name",
        :description => "Description",
        :imgage => "Imgage"
      ),
      stub_model(Sport,
        :name => "Name",
        :description => "Description",
        :imgage => "Imgage"
      )
    ])
  end

  it "renders a list of sports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Imgage".to_s, :count => 2
  end
end
