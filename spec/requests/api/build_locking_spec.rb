require "spec_helper"

describe "GET /api/build_lock" do
  let(:lock_attributes) {
    {
      token: "test-api-token", repository: "repository-url", name: "foo_tests"
    }
  }

  it "returns if a build is currently locked by another client", :redis do
    post "/api/build/lock", lock_attributes.merge(revision: "old_revision")
    expect(JSON.parse(response.body)).to eq({ "build_locked_by" => "old_revision" })

    post "/api/build/lock", lock_attributes.merge(revision: "new_revision")
    expect(JSON.parse(response.body)).to eq({ "build_locked_by" => "old_revision" })

    post "/api/build/unlock", token: "test-api-token", repository: "repository-url", name: "foo_tests"
    expect(response).to be_success

    post "/api/build/lock", lock_attributes.merge(revision: "new_revision")
    expect(JSON.parse(response.body)).to eq({ "build_locked_by" => "new_revision" })
  end
end
