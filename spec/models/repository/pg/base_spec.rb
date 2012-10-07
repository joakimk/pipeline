require 'spec_helper'

class TestEntity < Entity::Base
  attributes :name, :github_url
  validates :name, presence: true
end

class TestRepo < Repository::PG::Base
  entity_klass TestEntity

  def record_klass
    Record
  end

  class Record < ActiveRecord::Base
    attr_accessible :name
    self.table_name = :projects
  end
end

describe Repository::PG::Base, :pg do
  let(:repository) { TestRepo.new }
  let(:entity_klass) { TestEntity }

  include_examples :repository
end
