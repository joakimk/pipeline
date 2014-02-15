require "spec_helper"

describe Project do
  it "is valid" do
    FactoryGirl.build(:project).should be_valid
  end

  it "requires a name" do
    FactoryGirl.build(:project, name: nil).should_not be_valid
  end
end

describe Project do
  it "sets the name from repository" do
    project = Project.new(repository: "git@example.com:user/foo.git")
    expect(project.name).to eq("foo")
  end
end

describe Project, "latest_revisions" do
  it "returns the latest revisions in order" do
    project = FactoryGirl.create(:project)
    rev1 = FactoryGirl.create(:revision, project: project)
    rev2 = FactoryGirl.create(:revision, project: project)
    rev3 = FactoryGirl.create(:revision, project: project)
    expect(project.latest_revisions(2).map(&:id)).to eq([ rev3.id, rev2.id ])
  end
end

describe Project, "github_url" do
  it "is based on the repository" do
    project = Project.new(repository: "git@github.com:joakimk/deployer.git")
    expect(project.github_url).to eq("https://github.com/joakimk/deployer")
  end

  it "is nil when the repository is not on github" do
    expect(Project.new(repository: "git@example.com:foo.git").github_url).to be_nil
    expect(Project.new.github_url).to be_nil
  end
end

describe Project, "github_wiki_url" do
  it "is based on the repository" do
    project = Project.new(repository: "git@github.com:joakimk/deployer.git")
    expect(project.github_wiki_url).to eq("https://github.com/joakimk/deployer/wiki")
  end

  it "is nil when the repository is not on github" do
    expect(Project.new(repository: "git@example.com:foo.git").github_wiki_url).to be_nil
    expect(Project.new.github_url).to be_nil
  end
end

describe Project, ".all_sorted_by_name" do
  it "returns all projects projects alphabetically" do
    FactoryGirl.create(:project, name: "alpha")
    FactoryGirl.create(:project, name: "beta")

    Project.all_sorted_by_name.map(&:name).should == [ "alpha", "beta" ]
  end
end
