require 'repositories/memory/mapper'
require 'repositories/common'

class TestEntity < Minirepo::Entity
  attributes :name
  validates :name, presence: true
end

describe Repository::Memory::Mapper do
  let(:repository) { described_class.new }
  let(:entity_klass) { TestEntity }

  include_examples :mapper
end

describe Repository::Memory::Mapper, "all" do
  let(:repository) { described_class.new }

  it "does not return the internal list" do
    list = repository.all
    list << "foo"
    repository.all.should be_empty
  end
end
