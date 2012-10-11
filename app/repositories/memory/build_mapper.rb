require 'minimapper/memory'

module Repository
  module Memory
    class BuildMapper < Minimapper::Memory
      def find_known_by(attributes)
        all.find { |b| b.project  == attributes[:project] &&
                       b.step     == attributes[:step] &&
                       b.revision == attributes[:revision] }
      end
    end
  end
end
