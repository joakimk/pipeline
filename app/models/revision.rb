class Revision < ActiveRecord::Base
  attr_accessible :name, :project_id

  validates :name, format: /^[a-z0-9]{40}$/

  belongs_to :project
  has_many :builds, dependent: :destroy

  def self.find_or_create_for_project_and_name(project, name)
    where(project_id: project, name: name).first_or_create!
  end

  def build_mappings
    BuildMapping.build_list(project.mappings)
  end

  def for_build(name)
    builds.where(name: name).first
  end
end
