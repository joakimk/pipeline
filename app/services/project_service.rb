class ProjectService
  def initialize(repository)
    @projects = repository.projects
  end

  def add_project(attributes, client)
    @projects.add_by_attributes(attributes, client)
  end
end
