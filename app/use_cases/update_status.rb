require 'entity/build'

module UseCase
  class UpdateStatus
    def initialize(repository)
      @builds = repository.builds
    end

    def with(attributes)
      build = builds.find_known_by(attributes)

      if build
        build.status = attributes[:status]
        builds.update(build)
      else
        builds.add(Entity::Build.new(attributes))
      end
    end

    private

    attr_reader :builds
  end
end
