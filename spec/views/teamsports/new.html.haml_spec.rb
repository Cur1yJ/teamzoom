require 'spec_helper'

describe "teamsports/new" do
  before(:each) do
    assign(:teamsport, stub_model(Teamsport,
      :sport_id => "MyString",
      :team_id => "MyString"
    ).as_new_record)
  end

  it "renders new teamsport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teamsports_path, :method => "post" do
      assert_select "input#teamsport_sport_id", :name => "teamsport[sport_id]"
      assert_select "input#teamsport_team_id", :name => "teamsport[team_id]"
    end
  end
end
