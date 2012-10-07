require 'repository_backend'

module Repository
  class PG < RepositoryBackend
    def projects
      @projects ||= Project.new
    end

    def builds
      @builds ||= Build.new
    end
  end
end
