require 'build'
require 'attr_extras'

# Intended to be used by a client within a CI server to post status to this app.
class UpdateBuildStatus
  method_object :run,
    :name, :repository, :revision_hash, :status, :status_url

  def run
    if known_build?
      update_build_status
    else
      create_build
      limit_build_history
    end

    project
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
      last_revision_id_to_keep = revisions.order("id DESC").limit(App.revisions_to_keep).pluck(:id).last
      revisions.where("id < ?", last_revision_id_to_keep).each(&:destroy)
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
