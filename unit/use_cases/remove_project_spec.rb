require 'spec_helper'
require 'remove_project'
require 'repositories/memory'
require 'repositories/memory/project_mapper'

describe RemoveProject do
  let(:repository) { Repository::Memory.instance }

  before do
    repository.projects.delete_all
  end

  it "deletes the project" do
    project = FactoryGirl.create(:entity_project)
    repository.projects.add(project)
    RemoveProject.run(repository, project.id)
    repository.projects.all.should be_empty
  end
end
