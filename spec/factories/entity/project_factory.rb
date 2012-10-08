require 'project'

FactoryGirl.define do
  factory :entity_project, class: Project do
    name 'Deployer'
    skip_create
  end
end
