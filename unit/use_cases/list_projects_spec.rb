require 'list_projects'

describe ListProjects, "self.run" do
  let(:repository) { App.repository }

  it "returns all projects" do
    project = FactoryGirl.create(:entity_project, name: "testbot")
    repository.projects.add(project)

    projects = ListProjects.run(repository)
    projects.size.should == 1
    projects.first.name.should == "testbot"
  end

  it "orders the projects alphabetically" do
    project = FactoryGirl.create(:entity_project, name: "testbot")
    repository.projects.add(project)

    project = FactoryGirl.create(:entity_project, name: "deployer")
    repository.projects.add(project)

    ListProjects.run(repository).map(&:name).should == [ "deployer", "testbot" ]
  end
end
