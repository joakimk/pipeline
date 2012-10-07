require 'repository/pg'

module Repository
  class PG::Base
    def self.entity_klass(klass)
      self._entity_klass = klass
    end

    def self.attr_accessible(*attributes)
      Record.attr_accessible(*attributes)
    end

    def self.table_name(table_name)
      Record.table_name = table_name
    end

    def add(entity)
      if entity.valid?
        entity.id = Record.create!(entity.attributes).id
      else
        false
      end
    end

    def update(entity)
      if entity.id
        record = Record.find_by_id(entity.id)
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

    def last
      record = Record.last
      if record
        _entity_klass.new(Record.last.attributes)
      else
        nil
      end
    end

    def all
      Record.all.map { |record| _entity_klass.new(record.attributes) }
    end

    def delete_all
      Record.delete_all
    end

    def count
      Record.count
    end

    private

    class_attribute :_entity_klass

    class Record < ActiveRecord::Base
    end
  end
end
