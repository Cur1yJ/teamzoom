require "spec_helper"

describe TeamsportsController do
  describe "routing" do

    it "routes to #index" do
      get("/teamsports").should route_to("teamsports#index")
    end

    it "routes to #new" do
      get("/teamsports/new").should route_to("teamsports#new")
    end

    it "routes to #show" do
      get("/teamsports/1").should route_to("teamsports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/teamsports/1/edit").should route_to("teamsports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/teamsports").should route_to("teamsports#create")
    end

    it "routes to #update" do
      put("/teamsports/1").should route_to("teamsports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/teamsports/1").should route_to("teamsports#destroy", :id => "1")
    end

  end
end
