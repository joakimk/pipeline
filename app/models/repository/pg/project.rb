require 'repository/pg/base'
require 'repository/common/project'

module Repository
  class PG::Project < PG::Base
    include Repository::Common::Project
    table_name :projects
    entity_klass Entity::Project
    attr_accessible :name, :github_url, :created_at, :updated_at
  end
end
