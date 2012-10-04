require 'entity/base'

module Entity
  class Project < Entity::Base
    attr_accessor :name, :github_url

    validates :name, presence: true
  end
end
