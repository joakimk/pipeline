module Minimapper
  class MemoryMapper
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
      known_entity = find_by_entity(entity)
      known_entity.attributes = entity.attributes
      true
    end

    def delete(entity)
      known_entity = find_by_entity(entity)
      store.delete_if { |e| e.id == entity.id }
    end

    def delete_all
      store.clear
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

    private

    def find_by_entity(entity)
      (entity.id && store.find { |e| e.id == entity.id }) ||
        raise(Common::CanNotFindEntity, entity.inspect)
    end

    def next_id
      @last_id += 1
    end

    attr_reader :store, :last_id
  end
end
