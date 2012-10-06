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

describe Repository::PG::Base, "integration", :pg do
  it "can add a record and get it back" do
    repository = TestRepo.new
    repository.add(TestEntity.new(name: "test1"))
    repository.last.name.should == "test1"
  end
end
