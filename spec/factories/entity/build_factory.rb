require 'build'

FactoryGirl.define do
  factory :entity_build, class: Build do
    project_name "deployer"
    step_name "tests"
    revision "440f78f6de0c71e073707d9435db89f8e5390a59"
    status "building"
    skip_create
  end
end
