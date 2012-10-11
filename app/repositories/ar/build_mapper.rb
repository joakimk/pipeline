require 'minimapper/ar'

module AR
  class BuildMapper < Minimapper::AR
    def find_known_by(attributes)
      record_klass.where(
        project:  attributes[:project],
        step:     attributes[:step],
        revision: attributes[:revision]
      ).first
    end
  end

  class Build < ActiveRecord::Base
    attr_accessible :project, :step, :revision, :status
  end
end
