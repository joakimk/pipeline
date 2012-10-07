require 'repository/memory'

module Repository
  class Memory::Base
    def initialize
      @store = []
      @last_id = 0
    end

    def add(entity)
      if entity.valid?
        entity.id = next_id
        store.push(entity.dup)
        last_id
      else
        false
      end
    end

    def update(entity)
      if entity.id
        stored_entity = store.find { |e| e.id == entity.id }
        if stored_entity
          stored_entity.attributes = entity.attributes
          true
        else
          raise Common::CanNotFindEntity, id: entity.id
        end
      else
        raise Common::CanNotUpdateEntityWithoutId, entity.inspect
      end
    end

    def delete(entity)
      store.delete_if { |e| e.id == entity.id }
    end

    def first
      store.first
    end

    def last
      store.last
    end

    def count
      all.size
    end

    def all
      store.dup
    end

    def delete_all
      store.clear
    end

    private

    def next_id
      @last_id += 1
    end

    attr_reader :store, :last_id
  end
end
