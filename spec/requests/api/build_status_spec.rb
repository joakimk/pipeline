require 'spec_helper'

describe "POST /api/build_status", type: :request do
  let(:attributes) {
    {
      name: "foo_tests",
      repository: "git@example.com:user/foo.git",
      revision: "440f78f6de0c71e073707d9435db89f8e5390a59",
      status: "building",
    }
  }

  it "adds or updates build status" do
    App.stub(api_token: 'secret')
    post "/api/build_status", attributes.merge(token: "secret", status: "successful")
    response.should be_success
    Build.last.status.should == "successful"
  end

  it "fails when the api token is wrong" do
    post "/api/build_status", attributes.merge(token: "secret")
    response.code.should == "401"
    Build.all.should be_empty
  end
end
