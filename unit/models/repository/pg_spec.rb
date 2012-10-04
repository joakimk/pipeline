require 'repository/pg'
require 'repository/pg/project'

describe Repository::PG do
  subject { described_class }
  implements_role :repository_backend
end

describe Repository::PG, "projects" do
  it "returns an instance of Repository::PG::Project" do
    described_class.send(:new).projects.should be_kind_of(Repository::PG::Project)
  end

  it "is memoized" do
    repository = described_class.send(:new)
    repository.projects.object_id.should == repository.projects.object_id
  end
end
