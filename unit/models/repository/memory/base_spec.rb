require 'repository/memory/base'
require 'repository/common'
require 'entity/base'

describe Repository::Memory::Base do
  implements_role :base_repository
end

class TestEntity < Entity::Base
  attributes :name
  validates :name, presence: true
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

  it "validates the record before saving" do
    entity = TestEntity.new
    repository.add(entity).should be_false
  end
end

describe Repository::Memory::Base, "update" do
  let(:repository) { described_class.new }

  it "updates" do
    entity = TestEntity.new(name: "Test")
    repository.add(entity)

    entity.name = "Updated"
    repository.last.name.should == "Test"

    repository.update(entity)
    repository.last.id.should == entity.id
    repository.last.name.should == "Updated"
  end

  it "returns true" do
    entity = TestEntity.new(name: "Test")
    repository.add(entity)
    repository.update(entity).should == true
  end

  it "fails when the entity does not have an id" do
    entity = TestEntity.new(name: "Test")
    -> { repository.update(entity) }.should raise_error(Repository::Common::CanNotUpdateEntityWithoutId)
  end

  it "fails when the entity no longer exists" do
    entity = TestEntity.new(name: "Test")
    repository.add(entity)
    repository.delete_all
    -> { repository.update(entity) }.should raise_error(Repository::Common::CanNotFindEntity)
  end
end

describe Repository::Memory::Base, "delete_all" do
  let(:repository) { described_class.new }

  it "empties the repository" do
    repository.add(Entity::Base.new)
    repository.delete_all
    repository.all.should == []
  end
end

describe Repository::Memory::Base, "first" do
  let(:repository) { described_class.new }

  it "returns the first entity" do
    first_added_entity = Entity::Base.new
    repository.add(first_added_entity)
    repository.add(Entity::Base.new)
    repository.first.id.should == first_added_entity.id
  end
end

describe Repository::Memory::Base, "count" do
  let(:repository) { described_class.new }

  it "returns the number of entities" do
    repository.add(Entity::Base.new)
    repository.add(Entity::Base.new)
    repository.count.should == 2
  end
end

describe Repository::Memory::Base, "delete" do
  let(:repository) { described_class.new }

  it "removes the entity" do
    entity = Entity::Base.new
    repository.add(entity)
    repository.add(Entity::Base.new)
    repository.delete(entity)
    repository.all.size.should == 1
    repository.first.id.should_not == entity.id
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
