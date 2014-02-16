class RevisionPresenter
  pattr_initialize :revision

  def name
    revision.name[0, 6]
  end

  def builds
    sorted_builds.map { |build|
      apply_mapping(build)
      build
    }
  end

  private

  def sorted_builds
    builds = build_mappings.map { |mapping|
      revision.builds.find { |b| b.name == mapping.from }
    }.compact

    builds += revision.builds
    builds.uniq
  end

  def apply_mapping(build)
    build_mappings.each do |mapping|
      mapping.apply(build)
    end
  end

  def build_mappings
    revision.build_mappings
  end
end
