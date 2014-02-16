class RevisionPresenter
  pattr_initialize :revision

  def name
    revision.name[0, 6]
  end

  def builds
    builds = with_pending(revision.builds)
    sort(builds).map { |build|
      apply_mapping(build)
      build
    }
  end

  private

  def sort(builds)
    out = build_mappings.map { |mapping|
      builds.find { |b| b.name == mapping.from }
    }

    out += builds
    out.uniq(&:name)
  end

  def with_pending(builds)
    out = []

    build_mappings.each do |mapping|
      unless builds.map(&:name).include?(mapping.from)
        out << Build.new(name: mapping.from, status: "pending")
      end
    end

    out += builds.map(&:dup)
    out
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
