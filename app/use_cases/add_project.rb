class AddProject
  def self.run(repository, attributes, client)
    repository.projects.create_by_attributes(attributes, client)
  end
end
