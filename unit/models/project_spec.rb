require 'project'

describe Project do
  it "is valid" do
    FactoryGirl.build(:project).should be_valid
  end

  it "requires a name" do
    FactoryGirl.build(:project, name: nil).should_not be_valid
  end
end
