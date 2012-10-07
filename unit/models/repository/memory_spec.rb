require 'repository/memory'
require 'repository/memory/project'
require 'repository/memory/build'

describe Repository::Memory do
  subject { described_class }
  implements_role :repository_backend
end

describe Repository::Memory, "projects" do
  it "returns an instance of Repository::Memory::Project" do
    described_class.send(:new).projects.should be_kind_of(Repository::Memory::Project)
  end

  it "is memoized" do
    repository = described_class.send(:new)
    repository.projects.object_id.should == repository.projects.object_id
  end
end

describe Repository::Memory, "builds" do
  it "returns an instance of Repository::Memory::Build" do
    described_class.send(:new).builds.should be_kind_of(Repository::Memory::Build)
  end

  it "is memoized" do
    repository = described_class.send(:new)
    repository.builds.object_id.should == repository.builds.object_id
  end
end
