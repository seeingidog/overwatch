require 'spec_helper'

module Overwatch
  describe Application do
    let(:resource) { Factory.stub(:resource) }
    
    before :each do
      header "Content-Type", "application/json"
      header "Accept", "application/json"
    end
    
    describe "GET on /resources" do      
      before :each do 
        Resource.stub(:all).and_return([resource])
        get "/resources"
      end

      it "lists all resources" do
        last_response.status.should == 200
        last_response.content_type.should == "application/json"
        last_response.body.should == Resource.all.to_json
      end
    end
    
    describe "GET on /resources/:id" do      
      before :each do
        Resource.stub(:find_by_name_or_id).with("1").and_return(resource)
        Resource.stub(:find_by_name_or_id).with("999").and_return(nil)
      end
      
      it "lists a single resource" do
        get "/resources/1"
        last_response.status.should == 200
        last_response.content_type.should == "application/json"
        last_response.body.should == Resource.find_by_name_or_id("1").to_json
      end
      
      it "404s on a resource not found" do
        get "/resources/999"
        last_response.status.should == 404
        last_response.body.should be_blank
      end
    end
    
    describe "POST on /resources" do
      let(:resource_attributes) { Factory.attributes_for(:resource) }
      
      before :each do
        puts resource_attributes.inspect
        # Resource.create(resource_attributes)
      end
    end
    
    describe "DELETE on /resources" do
    
    end
    
    describe "GET on /resources/1/regenerate_api_key" do
      
    end
    
    describe "POST on /resources/:api_key" do
      
    end
  end
end
