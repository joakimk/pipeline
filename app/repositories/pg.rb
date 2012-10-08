require 'repository_backend'

module Repository
  class PG < RepositoryBackend
    def projects
      @projects ||= ProjectMapper.new
    end

    def builds
      @builds ||= BuildMapper.new
    end
  end
end
