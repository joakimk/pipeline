module ListProjects
  def self.in(repository)
    sorted_by_name repository.projects.all
  end

  private

  def self.sorted_by_name(projects)
    projects.sort { |a, b| a.name <=> b.name }
  end
end
