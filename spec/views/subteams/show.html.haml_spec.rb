require 'spec_helper'

describe "subteams/show" do
  before(:each) do
    @subteam = assign(:subteam, stub_model(Subteam,
      :team_id => 1,
      :name => "Name",
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Image/)
  end
end
