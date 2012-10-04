require 'repository/pg'

module Repository
  class PG::Base
    def self.entity_type(klass)
      self.entity_klass = klass
    end

    def add(entity)
      if entity.valid?
        entity.id = Record.create.id
      else
        false
      end
    end

    def last
      entity_klass.new(Record.last_by_id.attributes)
    end

    def all
      Record.all.map { |record| entity_klass.new(record.attributes) }
    end

    def delete_all
      Record.delete_all
    end

    private

    cattr_accessor :entity_klass

    class Record < ActiveRecord::Base
    end
  end
end
