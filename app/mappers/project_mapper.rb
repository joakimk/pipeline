class ProjectMapper < Minimapper::AR
  def all_sorted_by_name
    entities_for record_klass.order("name ASC")
  end

  def record_klass
    Record
  end

  class Record < ActiveRecord::Base
    attr_accessible :name, :github_url
    attr_protected :created_at, :updated_at

    self.table_name = :projects
  end
end

