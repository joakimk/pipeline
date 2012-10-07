require 'update_status'
require 'repository/memory'
require 'repository/memory/build'

describe UseCase::UpdateStatus do
  let(:repository) { Repository::Memory.instance }
  let(:update_status) { described_class.new(repository) }

  after do
    repository.builds.delete_all
  end

  context "when there are no previous builds" do
    it "adds a build" do
      update_status.with({ project: 'deployer', step: 'tests', revision: '123', status: 'building' })

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
      update_status.with({ project: 'deployer', step: 'tests', revision: '123', status: 'building' })
      update_status.with({ project: 'deployer', step: 'tests', revision: '123', status: 'successful' })

      builds = repository.builds.all
      builds.size.should == 1
      builds.first.status.should == 'successful'
    end
  end
end
