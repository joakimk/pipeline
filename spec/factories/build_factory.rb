FactoryGirl.define do
  factory :build do
    name "pipeline_tests"
    revision { FactoryGirl.build(:revision) }
    status "building"
  end
end
