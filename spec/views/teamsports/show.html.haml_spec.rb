require 'spec_helper'

describe "teamsports/show" do
  before(:each) do
    @teamsport = assign(:teamsport, stub_model(Teamsport,
      :sport_id => "Sport",
      :team_id => "Team"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sport/)
    rendered.should match(/Team/)
  end
end
