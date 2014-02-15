FactoryGirl.define do
  factory :revision do
    name "440f78f6de0c71e073707d9435db89f8e5390a59"
    project { FactoryGirl.build(:project) }
  end
end
