require 'project'

describe Project do
  it "is valid" do
    FactoryGirl.build(:entity_project).should be_valid
  end

  it "requires a name" do
    FactoryGirl.build(:entity_project, name: nil).should_not be_valid
  end
end
