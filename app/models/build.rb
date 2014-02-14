require 'minimapper/entity'

class Build
  include Minimapper::Entity

  attribute :name
  attribute :revision
  attribute :status

  validates :name, :revision, :status, presence: true
  validates :revision, format: /^[a-z0-9]{40}$/
end
