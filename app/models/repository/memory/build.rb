require 'repository/memory/base'

module Repository
  class Memory::Build < Memory::Base
    def find_known_by(attributes)
      all.find { |b| b.project  == attributes[:project] &&
                     b.step     == attributes[:step] &&
                     b.revision == attributes[:revision] }
    end
  end
end
