require 'minimapper/ar'
require 'common/project_mapper'

module AR
  class ProjectMapper < Minimapper::AR
    include Common::ProjectMapper
  end

  class Project < ActiveRecord::Base
    attr_accessible :name, :github_url, :created_at, :updated_at
  end
end
