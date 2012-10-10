require 'spec_helper'

describe "POST /api/build_status" do
  after do
    App.repository.builds.delete_all
  end

  it "adds or updates build status" do
    App.stub(api_token: 'secret')
    post "/api/build_status", project: "testbot", step: "tests", revision: "999", status: "building", token: "secret"
    response.should be_success
    App.repository.builds.last.revision.should == "999"
  end

  it "fails when the api token is wrong" do
    post "/api/build_status", project: "testbot", step: "tests", revision: "999", status: "building", token: "secret"
    response.code.should == "401"
    App.repository.builds.all.should be_empty
  end
end
