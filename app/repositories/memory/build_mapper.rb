require 'minimapper/memory'

module Memory
  class BuildMapper < Minimapper::Memory
    def find_known_by(attributes)
      all.find { |b| b.project_id == attributes[:project_id].to_i &&
                     b.step       == attributes[:step] &&
                     b.revision   == attributes[:revision] }
    end
  end
end
