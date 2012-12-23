require 'minimapper/entity'

class Project
  include Minimapper::Entity

  attribute :name
  attribute :github_url

  validates :name, presence: true
end
