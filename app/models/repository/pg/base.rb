require 'repository/pg'

module Repository
  class PG::Base
    def self.entity_klass(klass)
      self._entity_klass = klass
    end

    def add(entity)
      if entity.valid?
        entity.id = record_klass.create!(entity.attributes).id
      else
        false
      end
    end

    def update(entity)
      if entity.id
        record = record_klass.find_by_id(entity.id)
        if record
          record.update_attributes!(entity.attributes)
          true
        else
          raise Common::CanNotFindEntity, id: entity.id
        end
      else
        raise Common::CanNotUpdateEntityWithoutId, entity.inspect
      end
    end

    def delete(entity)
      record_klass.find(entity.id).delete
    end

    def first
      entity_for(record_klass.first)
    end

    def last
      entity_for(record_klass.last)
    end

    def all
      record_klass.all.map { |record| _entity_klass.new(record.attributes) }
    end

    def delete_all
      record_klass.delete_all
    end

    def count
      record_klass.count
    end

    private

    def entity_for(record)
      if record
        _entity_klass.new(record.attributes)
      else
        nil
      end
    end

    class_attribute :_entity_klass
  end
end
