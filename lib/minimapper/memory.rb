module Minimapper
  class Memory
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

    def find(id)
      (id && store.find { |e| e.id == id.to_i }) ||
        raise(Common::CanNotFindEntity, id: id)
    end

    def update(entity)
      known_entity = find(entity.id)
      known_entity.attributes = entity.attributes
      true
    end

    def delete(entity)
      delete_by_id(entity.id)
    end

    def delete_by_id(id)
      entity = find(id)
      store.delete(entity)
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

    def next_id
      @last_id += 1
    end

    attr_reader :store, :last_id
  end
end
