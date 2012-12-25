require 'minimapper/ar'

module AR
  class ProjectMapper < Minimapper::AR
    def all_sorted_by_name
      record_klass.order("name ASC").map { |record| entity_for(record) }
    end
  end

  class Project < ActiveRecord::Base
    attr_accessible :name, :github_url, :created_at, :updated_at
  end
end
