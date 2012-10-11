require 'repositories/ar'

module Minimapper
  class AR
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
      delete_by_id(entity.id)
    end

    def delete_by_id(id)
      find_record(id).delete
    end

    def find(id)
      entity_for(find_record(id))
    end

    def first
      entity_for(record_klass.first)
    end

    def last
      entity_for(record_klass.last)
    end

    def all
      record_klass.all.map { |record| entity_klass.new(record.attributes) }
    end

    def delete_all
      record_klass.delete_all
    end

    def count
      record_klass.count
    end

    private

    def record_klass
      @record_klass ||= self.class.name.gsub(/Mapper/, '').constantize
    end

    def entity_klass
      @entity_klass ||= self.class.name.split('::').last.gsub(/Mapper/, '').constantize
    end

    def find_record(id)
      (id && record_klass.find_by_id(id)) ||
        raise(Common::CanNotFindEntity, id: id)
    end

    def record_for(entity)
      (entity.id && record_klass.find_by_id(entity.id)) ||
        raise(Common::CanNotFindEntity, entity.inspect)
    end

    def entity_for(record)
      if record
        entity_klass.new(record.attributes)
      else
        nil
      end
    end
  end
end
