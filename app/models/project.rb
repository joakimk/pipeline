require 'minimapper/entity'

class Project < Minimapper::Entity
  attributes :name, :github_url

  validates :name, presence: true
end
