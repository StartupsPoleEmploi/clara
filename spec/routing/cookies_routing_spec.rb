require "rails_helper"

RSpec.describe CookiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cookies").to route_to("cookies#index")
    end

    it "routes to #new" do
      expect(:get => "/cookies/new").to route_to("cookies#new")
    end

    it "routes to #show" do
      expect(:get => "/cookies/1").to route_to("cookies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cookies/1/edit").to route_to("cookies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cookies").to route_to("cookies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cookies/1").to route_to("cookies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cookies/1").to route_to("cookies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cookies/1").to route_to("cookies#destroy", :id => "1")
    end

  end
end
