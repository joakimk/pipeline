require 'build'

# Updates build status, creates new builds when needed.
# Intended to be used by a client within a CI server to post status to this app.
class BuildStatusService
  def initialize(repository)
    @builds = repository.builds
  end

  def update_status(attributes)
    build = builds.find_known_by(attributes)

    if build
      build.status = attributes[:status]
      builds.update(build)
    else
      builds.add(Build.new(attributes))
      builds.delete(builds.first) if builds.count > App.builds_to_keep
    end
  end

  private

  attr_reader :builds
end
