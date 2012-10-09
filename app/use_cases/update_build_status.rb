require 'build'

# Intended to be used by a client within a CI server to post status to this app.
class UpdateBuildStatus
  def self.run(repository, attributes)
    builds = repository.builds
    build = builds.find_known_by(attributes)

    if build
      build.status = attributes[:status]
      builds.update(build)
    else
      builds.add(Build.new(attributes))
      builds.delete(builds.first) if builds.count > App.builds_to_keep
    end
  end
end
