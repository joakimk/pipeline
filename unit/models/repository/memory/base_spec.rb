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
end

describe Repository::Memory::Base, "all" do
  let(:repository) { described_class.new }

  it "does not return the internal list" do
    list = repository.all
    list << "foo"
    repository.all.should be_empty
  end
end
