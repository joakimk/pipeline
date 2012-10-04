require 'repository_backend'

module Repository
  class Memory < RepositoryBackend
    def projects
      @projects ||= Project.new
    end
  end
end
