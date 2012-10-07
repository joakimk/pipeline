require 'repository/memory/base'
require 'repository/common'
require 'entity/base'

class TestEntity < Entity::Base
  attributes :name
  validates :name, presence: true
end

describe Repository::Memory::Base do
  let(:repository) { described_class.new }
  let(:entity_klass) { TestEntity }

  include_examples :repository
  implements_role :base_repository
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
