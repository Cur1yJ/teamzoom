require 'spec_helper'

describe "sports/edit" do
  before(:each) do
    @sport = assign(:sport, stub_model(Sport,
      :name => "MyString",
      :description => "MyString",
      :imgage => "MyString"
    ))
  end

  it "renders the edit sport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sports_path(@sport), :method => "post" do
      assert_select "input#sport_name", :name => "sport[name]"
      assert_select "input#sport_description", :name => "sport[description]"
      assert_select "input#sport_imgage", :name => "sport[imgage]"
    end
  end
end
