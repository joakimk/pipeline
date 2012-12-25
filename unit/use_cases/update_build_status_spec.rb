require "update_build_status"

describe UpdateBuildStatus do
  let(:repository) { App.repository }
  let(:update_build_status) { described_class }

  def update_with(custom = {})
    build_attributes = FactoryGirl.attributes_for(:build).merge(custom)
    update_build_status.run(repository, build_attributes)
  end

  context "when there are no previous builds" do
    it "adds a build" do
      update_with project_name: "deployer"

      builds = repository.builds.all
      builds.size.should == 1
      builds.first.project_name.should == "deployer"
    end
  end

  context "when there are previous builds" do
    it "updates the status" do
      update_with status: "building"
      update_with status: "successful"

      builds = repository.builds.all
      builds.size.should == 1
      builds.first.status.should == "successful"
    end
  end

  context "when there are more than App.builds_to_keep builds" do
    it "removes the oldest build" do
      App.stub(builds_to_keep: 2)
      update_with revision: "123"
      update_with revision: "456"
      update_with revision: "789"

      repository.builds.all.map(&:revision).should == [ "456", "789" ]
    end
  end
end
