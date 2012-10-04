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

describe Repository::PG::Base, "add" do
  let(:repository) { described_class.new }

  it "sets an id on the entity" do
    TestRepo::Record.stub(create: mock(id: 22))

    entity = Entity::Base.new
    entity.id.should be_nil

    repository.add(entity)
    entity.id.should == 22
  end

  it "returns the id" do
    TestRepo::Record.stub(create: mock(id: 55))
    entity = Entity::Base.new
    repository.add(entity).should == 55
  end

  it "validates the record before saving" do
    TestRepo::Record.should_not_receive(:create)
    entity = TestEntity.new
    repository.add(entity).should be_false
  end

  it "creates the record" do
    TestRepo::Record.should_receive(:create).with(name: "Test").and_return(mock(id: 1))
    entity = TestEntity.new(name: "Test")
    repository.add(entity)
  end
end

describe Repository::PG::Base, "delete_all" do
  let(:repository) { described_class.new }

  it "forwards to the record" do
    TestRepo::Record.should_receive(:delete_all)
    repository.delete_all
  end
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
