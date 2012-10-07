require 'repository/pg/base'
require 'entity/base'

describe Repository::PG::Base do
  implements_role :base_repository
end

class TestEntity < Entity::Base
  attributes :name
  validates :name, presence: true
end

class TestRepo < Repository::PG::Base
  entity_klass TestEntity
end

describe Repository::PG::Base, "last" do
  let(:repository) { TestRepo.new }

  it "returns the last entity" do
    record = mock(attributes: { id: 22, name: "Test" })
    TestRepo::Record.stub(last: record)
    entity = repository.last
    entity.id.should == 22
    entity.should be_kind_of(TestEntity)
    entity.name.should == "Test"
  end

  it "returns nil when there is no last record" do
    TestRepo::Record.stub(last: nil)
    repository.last.should be_nil
  end
end

describe Repository::PG::Base, "count" do
  let(:repository) { TestRepo.new }

  it "returns the number of entities" do
    TestRepo::Record.stub(count: 2)
    repository.count.should == 2
  end
end

describe Repository::PG::Base, "all" do
  let(:repository) { TestRepo.new }

  it "returns all entities" do
    record = mock(attributes: { id: 22, name: "Test" })
    TestRepo::Record.should_receive(:all).and_return([ record ])

    entities = repository.all
    entities.size.should == 1

    entity = entities.first
    entity.id.should == 22
    entity.should be_kind_of(TestEntity)
    entity.name.should == "Test"
  end
end
