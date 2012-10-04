require 'repository/memory/base'
require 'entity/base'

describe Repository::Memory::Base do
  implements_role :base_repository
end

class TestEntity < Entity::Base
  attribute :name, String
end

describe Repository::Memory::Base, "add" do
  let(:repository) { described_class.new }

  it "sets an id on the entity" do
    entity1 = Entity::Base.new
    entity1.id.should be_nil
    repository.add(entity1)
    entity1.id.should == 1

    entity2 = Entity::Base.new
    repository.add(entity2)
    entity2.id.should == 2
  end

  it "returns the id" do
    repository.add(Entity::Base.new).should == 1
  end

  it "does not store by reference" do
    entity = TestEntity.new(name: "Test")
    repository.add(entity)
    repository.last.object_id.should_not == entity.object_id
    repository.last.name.should == "Test"
  end
end

describe Repository::Memory::Base, "last" do
  let(:repository) { described_class.new }

  it "returns the last entity" do
    last_added_entity = Entity::Base.new
    repository.add(Entity::Base.new)
    repository.add(last_added_entity)
    repository.last.id.should == last_added_entity.id
  end
end

describe Repository::Memory::Base, "all" do
  let(:repository) { described_class.new }

  it "does not return the internal list" do
    list = repository.all
    list << "foo"
    repository.all.should be_empty
  end
end
