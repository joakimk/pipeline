require 'repository/pg/base'
require 'repository/common/project'

module Repository
  class PG::Project < PG::Base
    include Repository::Common::Project
    entity_klass Entity::Project

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
