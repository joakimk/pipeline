require 'minimapper/memory'
require 'common/project_mapper'

module Memory
  class ProjectMapper < Minimapper::Memory
    include Common::ProjectMapper
  end
end
