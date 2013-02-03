require File.expand_path('../spec_helper.rb', File.dirname(__FILE__))

# See for further examples: https://github.com/rails3book/ticketee/blob/master/spec/api/v3/json/tickets_spec.rb

describe "Apps Listing", :type => :api do

  context "when creating an app" do
    let!(:auth) { FactoryGirl.create(:auth) }

    before do
      post '/app/new', :name => "Test App", :stub => "test-app", :key => auth.apikey
    end

    it "should be in the apps list" do
      get '/apps/index.json', :key => auth.apikey
      last_response.should be_ok

      apps = JSON.parse last_response.body
      apps.length.should == 1
      apps.first["name"].should == "Test App"
      apps.first["stub"].should == "test-app"
    end

    it "should be accessible directly via stub" do
      get '/app/test-app.json', :key => auth.apikey
      last_response.should be_ok

      data = JSON.parse last_response.body
      data["name"].should == "Test App"
      data["stub"].should == "test-app"
    end
  end

  context "when checking key validity" do
    # TODO: Move this out to a shared example; invoices and apps both need this.

    # Unused, but make sure we have something to fail the check against.
    let!(:auth) { FactoryGirl.create(:auth) }
    let!(:application) { FactoryGirl.create(:app, :stub => "test-app") }

    it "should fail invalid post requests" do
      post '/app/new', :name => "Test App", :stub => "test-app", :key => "invalid"
      last_response.should_not be_ok
    end

    it "should fail invalid app listing requests" do
      post '/apps/index.json', :key => "invalid"
      last_response.should_not be_ok
    end

    it "should fail invalid direct app requests" do
      post '/apps/test-app', :key => "invalid"
      last_response.should_not be_ok
    end
  end
end
