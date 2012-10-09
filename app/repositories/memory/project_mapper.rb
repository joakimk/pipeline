require 'minimapper/memory_mapper'
require 'repositories/common/project_mapper'
require 'repositories/memory'

module Repository
  class Memory::ProjectMapper < Minimapper::MemoryMapper
    include Repository::Common::ProjectMapper
  end
end
