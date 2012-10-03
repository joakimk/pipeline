require 'entity/base'

module Entity
  class Project < Entity::Base
    attribute :name, String
    attribute :github_url, String

    validates :name, presence: true
  end
end
