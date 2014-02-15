require "spec_helper"

describe Revision do
  it "requires a valid revision" do
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390a59").should be_valid
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390a5").should_not be_valid
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390A59").should_not be_valid
    FactoryGirl.build(:revision, name: "440f78f6de0c71e073707d9435db89f8e5390a5 ").should_not be_valid
  end
end
