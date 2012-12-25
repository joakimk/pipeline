require 'build'

FactoryGirl.define do
  factory :build do
    project_name "deployer"
    step_name "tests"
    revision "440f78f6de0c71e073707d9435db89f8e5390a59"
    status "building"
  end
end
