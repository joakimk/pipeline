require 'repository_backend'

module Repository
  class Memory < RepositoryBackend
    def projects
      @projects ||= ProjectMapper.new
    end

    def builds
      @builds ||= BuildMapper.new
    end
  end
end
