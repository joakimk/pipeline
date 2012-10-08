require 'spec_helper'

class TestEntity < Entity::Base
  attributes :name, :github_url
  validates :name, presence: true
end

class TestMapper < Repository::AR::Mapper
  entity_klass TestEntity

  def record_klass
    Record
  end

  class Record < ActiveRecord::Base
    attr_accessible :name
    self.table_name = :projects
  end
end

describe Repository::AR::Mapper, :pg do
  let(:repository) { TestMapper.new }
  let(:entity_klass) { TestEntity }

  include_examples :mapper
end
