require 'spec_helper'

describe "POST /api/status" do
  after do
    App.repository.builds.delete_all
  end

  it "adds or updates build status", :memory_only do
    App.stub(api_token: 'secret')
    post "/api/status", project: "testbot", step: "tests", revision: "999", status: "building", token: "secret"
    response.should be_success
    App.repository.builds.last.revision.should == "999"
  end

  it "fails when the api token is wrong", :memory_only do
    post "/api/status", project: "testbot", step: "tests", revision: "999", status: "building", token: "secret"
    response.code.should == "401"
    App.repository.builds.all.should be_empty
  end
end
