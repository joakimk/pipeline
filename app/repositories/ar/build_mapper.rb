require 'minimapper/ar'

module Repository
  class AR::BuildMapper < Minimapper::AR
    entity_klass Build

    def find_known_by(attributes)
      record_klass.where(
        project:  attributes[:project],
        step:     attributes[:step],
        revision: attributes[:revision]
      ).first
    end
  end

  class AR::Build < ActiveRecord::Base
    attr_accessible :project, :step, :revision, :status
  end
end
