module RemoveProject
  def self.run(repository, project_id)
    repository.projects.delete_by_id(project_id)
  end
end
