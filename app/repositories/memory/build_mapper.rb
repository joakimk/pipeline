require 'minimapper/memory'

module Memory
  class BuildMapper < Minimapper::Memory
    def find_known_by(attributes)
      all.find { |b| b.project_name == attributes[:project_name] &&
                     b.step_name    == attributes[:step_name] &&
                     b.revision     == attributes[:revision] }
    end
  end
end
