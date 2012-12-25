require 'minimapper/memory'

module Memory
  class ProjectMapper < Minimapper::Memory
    def all_sorted_by_name
      all.sort_by(&:name)
    end
  end
end
