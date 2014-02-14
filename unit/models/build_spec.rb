require 'build'

describe Build do
  it "requires a name" do
    FactoryGirl.build(:build, name: nil).should_not be_valid
  end

  it "requires a revision" do
    FactoryGirl.build(:build, revision: nil).should_not be_valid
  end

  it "requires a status" do
    FactoryGirl.build(:build, status: nil).should_not be_valid
  end

  it "requires a valid revision" do
    FactoryGirl.build(:build, revision: "440f78f6de0c71e073707d9435db89f8e5390a59").should be_valid
    FactoryGirl.build(:build, revision: "440f78f6de0c71e073707d9435db89f8e5390a5").should_not be_valid
    FactoryGirl.build(:build, revision: "440f78f6de0c71e073707d9435db89f8e5390A59").should_not be_valid
    FactoryGirl.build(:build, revision: "440f78f6de0c71e073707d9435db89f8e5390a5 ").should_not be_valid
  end
end
