require 'entity/project'

FactoryGirl.define do
  factory :entity_project, class: Entity::Project do
    name 'Deployer'
    skip_create
  end
end
