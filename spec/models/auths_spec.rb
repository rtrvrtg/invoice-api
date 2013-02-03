require File.expand_path('../spec_helper.rb', File.dirname(__FILE__))

describe Auth do
  context "authorising by API Key" do
    let(:valid_key) { "thisisakey" }
    let!(:record) { FactoryGirl.create(:auth, :apikey => valid_key) }

    it "retrieves a record by API key" do
      auth = Auth.auth_api(valid_key)
      auth.should be_an Auth
      auth.apikey.should == valid_key
    end

    it "returns nil when access is denied" do
      Auth.auth_api("nopenotgonnawork").should be_nil
    end
  end

  context "authorising by username and password" do
    let!(:record) { FactoryGirl.create(:auth, :user => "Bob", :pass => "Bert Bert") }

    it "retrieves a record by username / password" do
      auth = Auth.auth_user("Bob", "Bert Bert")
      auth.should be_an Auth
      auth.user.should == "Bob"
    end

    it "also retrieves the auth's API key" do
      auth = Auth.auth_user("Bob", "Bert Bert")
      auth.apikey.should_not be_blank
    end

    it "returns nil when access is denied" do
      Auth.auth_user("Bob", "Wrong Wrong").should be_nil
      Auth.auth_user("Wrong", "Bert Bert").should be_nil
      Auth.auth_user("Wrong", "Still Wrong").should be_nil
    end
  end
end

