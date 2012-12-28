require 'minimapper/ar'

module AR
  class ProjectMapper < Minimapper::AR
    def all_sorted_by_name
      entities_for record_klass.order("name ASC")
    end
  end

  class Project < ActiveRecord::Base
    attr_accessible :name, :github_url
    attr_protected :created_at, :updated_at
  end
end
