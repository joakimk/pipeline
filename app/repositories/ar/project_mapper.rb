require 'repositories/ar/mapper'
require 'repositories/common/project_mapper'

module Repository
  class AR::ProjectMapper < AR::Mapper
    include Repository::Common::ProjectMapper
    entity_klass Project

    private

    def record_klass
      Record
    end

    class Record < ActiveRecord::Base
      attr_accessible :name, :github_url, :created_at, :updated_at
      self.table_name = :projects
    end
  end
end
