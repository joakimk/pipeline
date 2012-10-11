require 'minimapper/memory'
require 'repositories/common/project_mapper'

module Repository
  module Memory
    class ProjectMapper < Minimapper::Memory
      include Repository::Common::ProjectMapper
    end
  end
end
