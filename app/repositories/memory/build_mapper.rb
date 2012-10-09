require 'minirepo/memory_mapper'
require 'repositories/memory'

module Repository
  class Memory::BuildMapper < Minirepo::MemoryMapper
    def find_known_by(attributes)
      all.find { |b| b.project  == attributes[:project] &&
                     b.step     == attributes[:step] &&
                     b.revision == attributes[:revision] }
    end
  end
end
