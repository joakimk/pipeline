require 'common/project_mapper'
require 'minimapper/memory'

describe Common::ProjectMapper do
  subject { Class.new.send(:include, described_class).new }
  implements_role :project_mapper
end

describe Common::ProjectMapper, "add_by_attributes" do
  class ProjectMapper < Minimapper::Memory
    include Common::ProjectMapper
  end

  let(:project_mapper) { ProjectMapper.new }
  let(:client) { mock }

  it "adds a project entity to itself" do
    project_mapper.add_by_attributes({ name: "Deployer" }, client.as_null_object)
    project_mapper.last.name.should == "Deployer"
  end

  it "tells the client a project was added when adding was successful" do
    client.should_receive(:project_was_added).with(instance_of(Project))
    project_mapper.add_by_attributes({ name: "Deployer" }, client)
  end

  it "tells the client a project could not be added when adding fails" do
    project_mapper.stub(add: nil)
    client.should_receive(:project_was_not_added).with(instance_of(Project))
    project_mapper.add_by_attributes({}, client)
  end
end
