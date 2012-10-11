module Common
  module ProjectMapper
    def add_by_attributes(attributes, client)
      project = Project.new(attributes)

      if add(project)
        client.project_was_added(project)
      else
        client.project_was_not_added(project)
      end
    end
  end
end
