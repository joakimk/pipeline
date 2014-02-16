class RevisionPresenter
  pattr_initialize :revision

  def name
    revision.name[0, 6]
  end

  def builds
    revision.builds.map { |build|
      apply_mapping(build)
      build
    }
  end

  private

  def apply_mapping(build)
    build_mappings.each do |mapping|
      mapping.apply(build)
    end
  end

  def build_mappings
    revision.build_mappings
  end
end
