require 'spec_helper'

class TestEntity < Entity::Base
  attributes :name, :github_url
  validates :name, presence: true
end

class TestRepo < Repository::PG::Base
  entity_klass TestEntity
  table_name :projects
  attr_accessible :name
end

describe Repository::PG::Base, :pg do
  let(:repository) { TestRepo.new }
  let(:entity_klass) { TestEntity }

  include_examples :repository
end
