require 'project'

describe Project do
  it "is valid" do
    FactoryGirl.build(:project).should be_valid
  end

  it "requires a name" do
    FactoryGirl.build(:project, name: nil).should_not be_valid
  end

  it "requires the name to be lowercase letters or numbers or underscore" do
    FactoryGirl.build(:project, name: "abc123").should be_valid
    FactoryGirl.build(:project, name: "abc_123").should be_valid
    FactoryGirl.build(:project, name: "ABC123").should_not be_valid
    FactoryGirl.build(:project, name: "abc-").should_not be_valid
  end
end
