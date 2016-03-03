class ProjectStatusSerializer
  pattr_initialize :project

  def serialize
    {
      project_name: project.name,
      project_removed: project.destroyed?,
      latest_revisions: project.latest_revisions.map { |revision| serialize_revision(revision) }
    }
  end

  private

  def serialize_revision(revision)
    presenter = RevisionPresenter.new(revision)

    {
      hash: revision.name,
      short_name: presenter.name,
      builds: presenter.builds.map { |build| serialize_build(build) },
    }
  end

  def serialize_build(build)
    {
      name: build.name,
      status: build.status,
    }
  end
end
