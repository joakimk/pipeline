class RevisionPresenter
  pattr_initialize :revision

  def name
    revision.name[0, 6]
  end
end
