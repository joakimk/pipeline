require 'minimapper/entity'

class Build < Minimapper::Entity
  attributes :project_id, :step, :revision, :status

  alias_method :old_project_id=, :project_id=

  # TODO: implement attribute conversions for basic types in minimapper
  def project_id=(project_id)
    self.old_project_id = project_id.to_i
  end
end
