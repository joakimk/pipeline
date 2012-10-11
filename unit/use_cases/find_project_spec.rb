require 'find_project'

describe FindProject, "self.by_id" do
  let(:repository) { App.repository }

  it "finds a project" do
    project = FactoryGirl.create(:entity_project)
    repository.projects.add(project)
    FindProject.by_id(repository, project.id).id.should == project.id
  end
end
