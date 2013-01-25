require 'spec_helper'

describe "subteams/new" do
  before(:each) do
    assign(:subteam, stub_model(Subteam,
      :team_id => 1,
      :name => "MyString",
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new subteam form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subteams_path, :method => "post" do
      assert_select "input#subteam_team_id", :name => "subteam[team_id]"
      assert_select "input#subteam_name", :name => "subteam[name]"
      assert_select "input#subteam_image", :name => "subteam[image]"
    end
  end
end
