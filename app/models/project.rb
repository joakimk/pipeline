require 'entity/base'

class Project < Entity::Base
  attributes :name, :github_url

  validates :name, presence: true
end
