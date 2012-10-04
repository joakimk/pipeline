require 'repository/common/project'
require 'repository/memory/base'

describe Repository::Common::Project do
  subject { Class.new.send(:include, described_class).new }
  implements_role :project_repository
end

describe Repository::Common::Project, "add_by_attributes" do
  class ProjectRepo < Repository::Memory::Base
    include Repository::Common::Project
  end

  let(:project_repo) { ProjectRepo.new }
  let(:client) { mock }

  it "adds a project entity to itself" do
    project_repo.add_by_attributes({ name: "Deployer" }, client.as_null_object)
    project_repo.last.name.should == "Deployer"
  end

  it "tells the client a project was added when adding was successful" do
    client.should_receive(:project_added).with(instance_of(Entity::Project))
    project_repo.add_by_attributes({}, client)
  end

  it "tells the client a project could not be added when adding fails" do
    project_repo.stub(add: nil)
    client.should_receive(:project_could_not_be_added).with(instance_of(Entity::Project))
    project_repo.add_by_attributes({}, client)
  end
end
