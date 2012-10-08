module Repository
  module Common
    module ProjectMapper
      def add_by_attributes(attributes, client)
        project = Project.new(attributes)

        if add(project)
          client.project_added(project)
        else
          client.project_could_not_be_added(project)
        end
      end
    end
  end
end
