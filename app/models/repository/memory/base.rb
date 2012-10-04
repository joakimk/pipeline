require 'repository/memory'

module Repository
  class Memory::Base
    def initialize
      @store = []
      @last_id = 0
    end

    def add(entity)
      entity.id = next_id
      store.push(entity.dup)
      last_id
    end

    def last
      store.last
    end

    def all
      store.dup
    end

    private

    def next_id
      @last_id += 1
    end

    attr_reader :store, :last_id
  end
end
