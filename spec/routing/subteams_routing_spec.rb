require "spec_helper"

describe SubteamsController do
  describe "routing" do

    it "routes to #index" do
      get("/subteams").should route_to("subteams#index")
    end

    it "routes to #new" do
      get("/subteams/new").should route_to("subteams#new")
    end

    it "routes to #show" do
      get("/subteams/1").should route_to("subteams#show", :id => "1")
    end

    it "routes to #edit" do
      get("/subteams/1/edit").should route_to("subteams#edit", :id => "1")
    end

    it "routes to #create" do
      post("/subteams").should route_to("subteams#create")
    end

    it "routes to #update" do
      put("/subteams/1").should route_to("subteams#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/subteams/1").should route_to("subteams#destroy", :id => "1")
    end

  end
end
