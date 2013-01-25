require 'spec_helper'

describe "teamsports/index" do
  before(:each) do
    assign(:teamsports, [
      stub_model(Teamsport,
        :sport_id => "Sport",
        :team_id => "Team"
      ),
      stub_model(Teamsport,
        :sport_id => "Sport",
        :team_id => "Team"
      )
    ])
  end

  it "renders a list of teamsports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sport".to_s, :count => 2
    assert_select "tr>td", :text => "Team".to_s, :count => 2
  end
end
