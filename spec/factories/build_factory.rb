FactoryGirl.define do
  factory :build do
    name "deployer_tests"
    revision { FactoryGirl.build(:revision) }
    status "building"
  end
end
