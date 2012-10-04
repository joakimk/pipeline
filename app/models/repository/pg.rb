require 'repository_backend'

module Repository
  class PG < RepositoryBackend
    def projects
      @projects ||= Project.new
    end
  end
end
