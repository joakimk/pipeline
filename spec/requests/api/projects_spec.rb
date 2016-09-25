require "spec_helper"

describe "DELETE /api/projects", type: :request do
  it "removes a project" do
    project1 = FactoryGirl.create(:project, name: "foo")
    project2 = FactoryGirl.create(:project, name: "bar")

    allow(App).to receive(:api_token).and_return("secret")

    delete "/api/projects/foo", token: "secret"

    expect(response).to be_success
    expect(Project.find_by_id(project1.id)).to be_nil
    expect(Project.find_by_id(project2.id)).not_to be_nil

    # denies access with an invalid token
    delete "/api/projects/foo", token: "invalid-secret"

    expect(response).not_to be_success
    expect(Project.find_by_id(project2.id)).not_to be_nil
  end
end
