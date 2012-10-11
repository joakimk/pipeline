module ListProjects
  def self.run(repository)
    sorted_by_name repository.projects.all
  end

  private

  def self.sorted_by_name(projects)
    projects.sort { |a, b| a.name <=> b.name }
  end
end
