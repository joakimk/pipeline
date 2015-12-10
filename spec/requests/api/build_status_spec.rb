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
    allow(App).to receive(:api_token).and_return("secret")
    post "/api/build_status", attributes.merge(token: "secret", status: "successful")
    expect(response).to be_success
    expect(Build.last.status).to eq("successful")
  end

  it "fails when the api token is wrong" do
    post "/api/build_status", attributes.merge(token: "secret")
    expect(response.code).to eq("401")
    expect(Build.all).to be_empty
  end
end
