require "spec_helper"

describe UpdateBuildStatus do
  context "when there are no previous builds" do
    it "adds a build, a revision and a project" do
      update_with name: "pipeline_tests", repository: "git@example.com:user/bar.git"

      builds = Build.all
      expect(builds.size).to eq(1)
      build = builds.first
      expect(build.name).to eq("pipeline_tests")
      expect(build.status_url).to eq("http://example.com/builds/1")
      expect(build.revision.project.name).to eq("bar")
    end
  end

  context "when there are previous builds" do
    it "updates the status" do
      update_with status: "building"
      update_with status: "successful", status_url: "http://example.com/updated"

      builds = Build.all
      expect(builds.size).to eq(1)
      expect(builds.first.status).to eq("successful")
      expect(builds.first.status_url).to eq("http://example.com/updated")
    end
  end

  context "when builds for a new revision is posted" do
    it "adds another revision" do
      update_with revision: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      update_with revision: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"

      expect(Revision.count).to eq(2)
    end
  end

  context "when there are more than App.builds_to_keep builds" do
    it "removes the builds that should not be kept" do
      allow(App).to receive(:revisions_to_keep).and_return(4)
      update_with revision: "0000000000000000000000000000000000000000"
      update_with revision: "1111111111111111111111111111111111111111"
      update_with revision: "2222222222222222222222222222222222222222"
      update_with revision: "3333333333333333333333333333333333333333"

      # Removes old revisions if the number is changed between updates
      allow(App).to receive(:revisions_to_keep).and_return(2)
      update_with revision: "4444444444444444444444444444444444444444"

      project = Project.last
      list = project.revisions.map(&:name).to_s
      expect(list).not_to include("0")
      expect(list).not_to include("1")
      expect(list).not_to include("2")
      expect(list).to include("3")
      expect(list).to include("4")

      expect(Build.count).to eq(2)
    end
  end

  def update_with(custom = {})
    attributes = {
      name: "foo_tests",
      repository: "git@example.com:user/foo.git",
      revision: "440f78f6de0c71e073707d9435db89f8e5390a59",
      status_url: "http://example.com/builds/1",
      status: "building",
    }.merge(custom)

    UpdateBuildStatus.call(
      attributes[:name],
      attributes[:repository],
      attributes[:revision],
      attributes[:status],
      attributes[:status_url],
    )
  end
end
