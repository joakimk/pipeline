require 'spec_helper'

describe "POST /api/build_status" do
  it "adds or updates build status" do
    App.stub(api_token: 'secret')
    post "/api/build_status", FactoryGirl.attributes_for(:build).merge(token: "secret", status: "successful")
    response.should be_success
    Build.last.status.should == "successful"
  end

  it "fails when the api token is wrong" do
    post "/api/build_status", FactoryGirl.attributes_for(:build).merge(token: "secret")
    response.code.should == "401"
    Build.all.should be_empty
  end
end
