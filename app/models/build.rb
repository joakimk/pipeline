require 'minimapper/entity'

class Build
  include Minimapper::Entity

  attribute :project_id, :integer
  attribute :step
  attribute :revision
  attribute :status
end
