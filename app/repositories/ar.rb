require 'repositories/base'

module Repository
  class AR < Repository::Base
    def projects
      @projects ||= ProjectMapper.new
    end

    def builds
      @builds ||= BuildMapper.new
    end
  end
end
