require 'spec_helper'

describe "subteams/index" do
  before(:each) do
    assign(:subteams, [
      stub_model(Subteam,
        :team_id => 1,
        :name => "Name",
        :image => "Image"
      ),
      stub_model(Subteam,
        :team_id => 1,
        :name => "Name",
        :image => "Image"
      )
    ])
  end

  it "renders a list of subteams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
