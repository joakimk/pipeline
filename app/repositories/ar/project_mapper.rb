require 'minimapper/ar'

module AR
  class ProjectMapper < Minimapper::AR
  end

  class Project < ActiveRecord::Base
    attr_accessible :name, :github_url, :created_at, :updated_at
  end
end
