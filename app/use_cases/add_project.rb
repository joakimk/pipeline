module UseCase
  module AddProject
    def self.run(repository, attributes, client)
      repository.projects.add_by_attributes(attributes, client)
    end
  end
end
