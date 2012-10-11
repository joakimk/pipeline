module FindProject
  def self.by_id(repository, id)
    repository.projects.find(id)
  end
end
