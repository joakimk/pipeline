require 'minimapper/ar'

module AR
  class BuildMapper < Minimapper::AR
    def find_known_by(attributes)
      record_klass.where(
        project_id:  attributes[:project_id],
        step:        attributes[:step],
        revision:    attributes[:revision]
      ).first
    end
  end

  class Build < ActiveRecord::Base
    # TODO: find out why minimapper assigns id, created_at and updated_at
    attr_accessible :id, :created_at, :updated_at, :project_id, :step, :revision, :status
  end
end
