require 'minimapper/memory'
require 'minimapper/common'

class TestEntity < Minimapper::Entity
  attributes :name
  validates :name, presence: true
end

describe Minimapper::Memory do
  let(:repository) { described_class.new }
  let(:entity_klass) { TestEntity }

  include_examples :mapper
end

describe Minimapper::Memory, "all" do
  let(:repository) { described_class.new }

  it "does not return the internal list" do
    list = repository.all
    list << "foo"
    repository.all.should be_empty
  end
end
