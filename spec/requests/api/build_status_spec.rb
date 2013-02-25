require 'spec_helper'

describe "POST /api/build_status", :db do
  it "adds or updates build status" do
    App.stub(api_token: 'secret')
    post "/api/build_status", FactoryGirl.attributes_for(:build).merge(token: "secret", step_name: "tests")
    response.should be_success
    App.repository.builds.last.step_name.should == "tests"
  end

  it "fails when the api token is wrong" do
    post "/api/build_status", FactoryGirl.attributes_for(:build).merge(token: "secret")
    response.code.should == "401"
    App.repository.builds.all.should be_empty
  end
end
