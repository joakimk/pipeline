require 'minimapper/entity'

class Build < Minimapper::Entity
  attributes [ :project_id, Integer ], :step, :revision, :status
end
