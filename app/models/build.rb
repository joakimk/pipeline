require 'entity/base'

class Build < Entity::Base
  attributes :project, :step, :revision, :status
end
