require 'update_project'

describe UpdateProject, "self.run" do
  let(:repository) { App.repository }
  let(:client) { mock }

  context "when successful" do
    it "updates the project" do
      project = FactoryGirl.create(:entity_project, name: "testbot")
      repository.projects.add(project)
      client.as_null_object
      UpdateProject.run(repository, project.id, { github_url: "http://github.com/joakimk/testbot" }, client)

      project = repository.projects.find(project.id)
      project.github_url.should == "http://github.com/joakimk/testbot"
      project.name.should == "testbot"
    end

    it "tells the client" do
      project = FactoryGirl.create(:entity_project, name: "testbot")
      repository.projects.add(project)
      client.should_receive(:project_was_updated).with(instance_of(Project))
      UpdateProject.run(repository, project.id, {}, client)
    end
  end

  context "when there are validation errors" do
    it "does not update the project" do
      project = FactoryGirl.create(:entity_project, name: "testbot")
      repository.projects.add(project)
      client.as_null_object
      UpdateProject.run(repository, project.id, { name: "" }, client)

      project = repository.projects.find(project.id)
      project.name.should == "testbot"
    end

    it "tells the client" do
      project = FactoryGirl.create(:entity_project, name: "testbot")
      repository.projects.add(project)
      client.should_receive(:project_was_not_updated).with(instance_of(Project))
      UpdateProject.run(repository, project.id, { name: "" }, client)
    end
  end
end
