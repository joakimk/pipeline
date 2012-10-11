class UpdateProject
  def self.with(repository, project_id, attributes, client)
    project = repository.projects.find(project_id)
    project.attributes = attributes

    if repository.projects.update(project)
      client.project_was_updated(project)
    else
      client.project_was_not_updated(project)
    end
  end
end
