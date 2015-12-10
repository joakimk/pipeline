class ProjectStatusSerializer
  pattr_initialize :project

  def serialize
    {
      project_name: project.name
    }
  end
end
