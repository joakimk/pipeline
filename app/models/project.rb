require 'minimapper/entity'

class Project
  include Minimapper::Entity
  attributes :name, :github_url

  validates :name, presence: true
end
