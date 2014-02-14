require 'minimapper/memory'

module Memory
  class BuildMapper < Minimapper::Memory
    def find_known_by(attributes)
      all.find { |b| b.name == attributes[:name] &&
                     b.revision     == attributes[:revision] }
    end
  end
end
