require "build_presenter"

class RevisionPresenter
  pattr_initialize :revision

  def name
    revision.name[0, 6]
  end

  def builds
    BuildPresenter.new(revision).list
  end
end
