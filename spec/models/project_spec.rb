require "spec_helper"

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

describe Project do
  it "sets the name from repository" do
    project = Project.new(repository: "git@example.com:user/foo.git")
    expect(project.name).to eq("foo")
  end
end

describe Project, ".all_sorted_by_name" do
  it "returns all projects projects alphabetically" do
    FactoryGirl.create(:project, name: "alpha")
    FactoryGirl.create(:project, name: "beta")

    Project.all_sorted_by_name.map(&:name).should == [ "alpha", "beta" ]
  end
end
