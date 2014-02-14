require 'build'
require 'attr_extras'

# Intended to be used by a client within a CI server to post status to this app.
class UpdateBuildStatus
  def self.run(attributes)
    new(attributes).run
  end

  attr_initialize :attributes
  attr_private :attributes

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
    @known_build ||= Build.find_known_by(attributes)
  end

  def update_build_status
    known_build.status = attributes[:status]
    known_build.save
  end

  def create_build
    build = Build.new(attributes)
    build.save
  end

  def limit_build_history
    if Build.count > App.builds_to_keep
      Build.order('id asc').first.destroy
    end
  end
end
