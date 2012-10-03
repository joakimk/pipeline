module Repository
  class Memory
    class Base
      def initialize
        @list = []
      end

      def add(entity)
        @list << entity
      end

      def last
        @list.last
      end

      def all
        @list.dup
      end
    end
  end
end
