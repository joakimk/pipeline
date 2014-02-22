require "spec_helper"

describe Revision do
  it "requires a valid revision" do
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390a59").should be_valid
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390a5").should_not be_valid
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390A59").should_not be_valid
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390a5 ").should_not be_valid
  end
end

describe Revision, "#github_url" do
  it "is a url to the revision on github" do
    project = mock_model(Project, github_url: "https://github.com/barsoom/pipeline")
    revision = Revision.new(name: "7220d9a3bdd24de48435406016177be7165b1cc2")
    revision.project = project
    expect(revision.github_url).to eq("https://github.com/barsoom/pipeline/commit/7220d9a3bdd24de48435406016177be7165b1cc2")
  end

  it "is nil when there are no such url" do
    revision = Revision.new
    revision.project = Project.new
    expect(revision.github_url).to be_nil
  end
end
