require 'spec_helper'

describe "teamsports/edit" do
  before(:each) do
    @teamsport = assign(:teamsport, stub_model(Teamsport,
      :sport_id => "MyString",
      :team_id => "MyString"
    ))
  end

  it "renders the edit teamsport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teamsports_path(@teamsport), :method => "post" do
      assert_select "input#teamsport_sport_id", :name => "teamsport[sport_id]"
      assert_select "input#teamsport_team_id", :name => "teamsport[team_id]"
    end
  end
end
