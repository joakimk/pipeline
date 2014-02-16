require 'build'
require 'attr_extras'

# Intended to be used by a client within a CI server to post status to this app.
class UpdateBuildStatus
  def self.run(attributes)
    new(attributes).run
  end

  def initialize(attributes)
    @name, @repository, @revision_hash, @status, @status_url =
      attributes[:name], attributes[:repository], attributes[:revision], attributes[:status], attributes[:status_url]
  end

  attr_private :name, :repository, :revision_hash, :status, :status_url

  def run
    if known_build?
      update_build_status
    else
      create_build
      limit_build_history
    end
  end

  private

  def update_build_status
    build.status = status
    build.status_url = status_url
    build.save!
  end

  def create_build
    build = Build.new
    build.name = name
    build.status = status
    build.status_url = status_url
    build.revision = revision
    build.save!
  end

  def limit_build_history
    revisions = project.revisions

    if revisions.count > App.revisions_to_keep
      revisions.order("id asc").first.destroy
    end
  end

  def known_build?
    build
  end

  def build
    @build ||= revision.for_build(name)
  end

  def revision
    @revision ||= Revision.find_or_create_for_project_and_name(project, revision_hash)
  end

  def project
    @project ||= Project.find_or_create_for_repository(repository)
  end
end
