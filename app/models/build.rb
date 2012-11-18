require 'minimapper/entity'

class Build
  include Minimapper::Entity
  attributes [ :project_id, :integer ], :step, :revision, :status
end
