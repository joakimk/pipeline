require 'minimapper/entity'

class Build
  include Minimapper::Entity

  attribute :project_name
  attribute :step_name
  attribute :revision
  attribute :status

  validates :project_name, :step_name, :revision, :status, presence: true
  validates :revision, format: /^[a-z0-9]{40}$/
end
