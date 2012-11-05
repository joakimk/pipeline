require 'minimapper/entity'

class Build
  include Minimapper::Entity
  attributes [ :project_id, Integer ], :step, :revision, :status
end
