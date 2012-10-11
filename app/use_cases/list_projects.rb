module ListProjects
  def self.in(repository)
    repository.projects.all.sort_by(&:name)
  end
end
