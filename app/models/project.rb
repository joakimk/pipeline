require 'minimapper/entity'

class Project
  include Minimapper::Entity

  attribute :name
  attribute :github_url
  attribute :build_pattern

  validates :name, presence: true, format: /\A[a-z0-9_]+\z/
end
