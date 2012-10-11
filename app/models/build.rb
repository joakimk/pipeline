require 'minimapper/entity'

class Build < Minimapper::Entity
  attributes :project, :step, :revision, :status
end
