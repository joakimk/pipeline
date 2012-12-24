require 'minimapper/entity'

class Build
  include Minimapper::Entity

  attribute :project_name
  attribute :step_name
  attribute :revision
  attribute :status
end
