require "rails_helper"

RSpec.describe LinksController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/links/new").to route_to("links#new")
    end

    it "routes to #link_through" do
      expect(:get => "/1").to route_to("links#link_through", :slug => "1")
    end

    it "routes to #edit" do
      expect(:get => "/1/edit").to route_to("links#edit", :slug => "1")
    end


    it "routes to #create" do
      expect(:post => "/links").to route_to("links#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/1").to route_to("links#expire", :slug => "1")
    end
  end
end
