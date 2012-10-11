require 'update_build_status'
require 'repositories/memory/build_mapper'

describe UpdateBuildStatus do
  let(:repository) { App.repository }
  let(:update_build_status) { described_class }

  context "when there are no previous builds" do
    it "adds a build" do
      update_build_status.run(repository, { project: 'deployer', step: 'tests', revision: '123', status: 'building' })

      builds = repository.builds.all
      builds.size.should == 1
      build = builds.first
      build.project.should == 'deployer'
      build.step.should == 'tests'
      build.revision.should == '123'
      build.status.should == 'building'
    end
  end

  context "when there are previous builds" do
    it "updates the status" do
      update_build_status.run(repository, { project: 'deployer', step: 'tests', revision: '123', status: 'building' })
      update_build_status.run(repository, { project: 'deployer', step: 'tests', revision: '123', status: 'successful' })

      builds = repository.builds.all
      builds.size.should == 1
      builds.first.status.should == 'successful'
    end
  end

  context "when there are more than App.builds_to_keep builds" do
    it "removes the oldest build" do
      App.stub(builds_to_keep: 2)
      update_build_status.run(repository, { project: 'app', step: 'tests', revision: '123', status: 'successful' })
      update_build_status.run(repository, { project: 'app', step: 'tests', revision: '456', status: 'successful' })
      update_build_status.run(repository, { project: 'app', step: 'tests', revision: '789', status: 'successful' })
      repository.builds.all.map(&:revision).should == [ '456', '789' ]
    end
  end
end
