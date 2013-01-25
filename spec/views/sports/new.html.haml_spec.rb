require 'spec_helper'

describe "sports/new" do
  before(:each) do
    assign(:sport, stub_model(Sport,
      :name => "MyString",
      :description => "MyString",
      :imgage => "MyString"
    ).as_new_record)
  end

  it "renders new sport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sports_path, :method => "post" do
      assert_select "input#sport_name", :name => "sport[name]"
      assert_select "input#sport_description", :name => "sport[description]"
      assert_select "input#sport_imgage", :name => "sport[imgage]"
    end
  end
end
