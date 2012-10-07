require 'entity/base'

module Entity
  class Build < Entity::Base
    attributes :project, :step, :revision, :status
  end
end
