require 'minimapper/ar'

module AR
  class BuildMapper < Minimapper::AR
    def find_known_by(attributes)
      entity_for record_klass.where(
        name:     attributes[:name],
        revision: attributes[:revision]
      ).first
    end
  end

  class Build < ActiveRecord::Base
    attr_accessible :name, :revision, :status

    # To not break the build reporter:
    #
    # These won't show up in the blacklist unless they're listed here. But
    # they are somehow treated as blacklisted attributes anyway by ActiveRecord...
    #
    # If we don't blacklist them minimapper will try and set them which will
    # lead to a ActiveModel::MassAssignmentSecurity::Error :(
    attr_protected :created_at, :updated_at
  end
end
