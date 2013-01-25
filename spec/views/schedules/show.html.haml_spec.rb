require 'spec_helper'

describe "schedules/show" do
  before(:each) do
    @schedule = assign(:schedule, stub_model(Schedule,
      :sport => "Sport",
      :location => "Location",
      :purchase => "Purchase",
      :date => "Date",
      :time => "Time"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sport/)
    rendered.should match(/Location/)
    rendered.should match(/Purchase/)
    rendered.should match(/Date/)
    rendered.should match(/Time/)
  end
end
