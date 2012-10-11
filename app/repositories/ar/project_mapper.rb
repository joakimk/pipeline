require 'minimapper/ar'
require 'repositories/common/project_mapper'

module Repository
  class AR::ProjectMapper < Minimapper::AR
    include Repository::Common::ProjectMapper
  end

  class AR::Project < ActiveRecord::Base
    attr_accessible :name, :github_url, :created_at, :updated_at
  end
end
