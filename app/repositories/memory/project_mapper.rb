require 'minimapper/memory'
require 'repositories/common/project_mapper'
require 'repositories/memory'

module Repository
  class Memory::ProjectMapper < Minimapper::Memory
    include Repository::Common::ProjectMapper
  end
end
