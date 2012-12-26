require 'minimapper/entity'

class Project
  include Minimapper::Entity

  attribute :name
  attribute :github_url

  validates :name, presence: true, format: /\A[a-z0-9_]+\z/
end
