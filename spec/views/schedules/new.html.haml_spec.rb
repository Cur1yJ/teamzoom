require 'spec_helper'

describe "schedules/new" do
  before(:each) do
    assign(:schedule, stub_model(Schedule,
      :sport => "MyString",
      :location => "MyString",
      :purchase => "MyString",
      :date => "MyString",
      :time => "MyString"
    ).as_new_record)
  end

  it "renders new schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schedules_path, :method => "post" do
      assert_select "input#schedule_sport", :name => "schedule[sport]"
      assert_select "input#schedule_location", :name => "schedule[location]"
      assert_select "input#schedule_purchase", :name => "schedule[purchase]"
      assert_select "input#schedule_date", :name => "schedule[date]"
      assert_select "input#schedule_time", :name => "schedule[time]"
    end
  end
end
