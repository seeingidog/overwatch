require 'spec_helper'

module Overwatch
  describe Application do
    describe "GET on /resources" do
      before :all do
        Overwatch::Resource.create(:name => "host.example.com")
      end
      
      it "should list all resources" do
        header "Content-Type", "application/json"
        header "Accept", "application/json"
        get "/resources"
        last_response.status.should == "200"
        last_response.content_type.should == "application/json"
      end
    end
    
  end
end
