require 'spec_helper'

describe "schedules/index" do
  before(:each) do
    assign(:schedules, [
      stub_model(Schedule,
        :sport => "Sport",
        :location => "Location",
        :purchase => "Purchase",
        :date => "Date",
        :time => "Time"
      ),
      stub_model(Schedule,
        :sport => "Sport",
        :location => "Location",
        :purchase => "Purchase",
        :date => "Date",
        :time => "Time"
      )
    ])
  end

  it "renders a list of schedules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sport".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Purchase".to_s, :count => 2
    assert_select "tr>td", :text => "Date".to_s, :count => 2
    assert_select "tr>td", :text => "Time".to_s, :count => 2
  end
end
