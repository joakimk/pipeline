require 'repositories/ar'

module Minimapper
  class AR
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
      record_for(entity).update_attributes!(entity.attributes)
      true
    end

    def delete(entity)
      record_for(entity).delete
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

    def record_for(entity)
      (entity.id && record_klass.find_by_id(entity.id)) ||
        raise(Common::CanNotFindEntity, entity.inspect)
    end

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
