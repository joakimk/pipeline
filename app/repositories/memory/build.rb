require 'repositories/memory/mapper'

module Repository
  class Memory::Build < Memory::Mapper
    def find_known_by(attributes)
      all.find { |b| b.project  == attributes[:project] &&
                     b.step     == attributes[:step] &&
                     b.revision == attributes[:revision] }
    end
  end
end
