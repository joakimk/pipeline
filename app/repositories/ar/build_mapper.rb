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

    private

    def record_klass
      Record
    end

    class Record < ActiveRecord::Base
      attr_accessible :project, :step, :revision, :status
      self.table_name = :builds
    end
  end
end
