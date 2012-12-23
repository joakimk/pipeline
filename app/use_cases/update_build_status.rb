require 'build'
require 'attr_extras'

# Intended to be used by a client within a CI server to post status to this app.
class UpdateBuildStatus
  def self.run(repository, attributes)
    new(repository, attributes).run
  end

  attr_initialize :repository, :attributes
  attr_private :repository, :attributes

  def run
    if known_build?
      update_build_status
    else
      create_build
      limit_build_history
    end
  end

  private

  def known_build?
    known_build
  end

  def known_build
    @known_build ||= build_mapper.find_known_by(attributes)
  end

  def update_build_status
    known_build.status = attributes[:status]
    build_mapper.update(known_build)
  end

  def create_build
    build = Build.new(attributes)
    build_mapper.create(build)
  end

  def limit_build_history
    if build_mapper.count > App.builds_to_keep
      build_mapper.delete(build_mapper.first)
    end
  end

  def build_mapper
    repository.builds
  end
end
