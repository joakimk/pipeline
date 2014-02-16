class RevisionPresenter
  pattr_initialize :revision

  def name
    revision.name[0, 6]
  end

  def builds
    builds = sort(with_pending(revision.builds))
    builds.map { |build|
      mapping = mapping_for_build(build)
      name = mapping ? mapping.to : build.name
      status = build.status
      build(name, status)
    }
  end

  private

  def mapping_for_build(build)
    build_mappings.find { |m| m.from == build.name }
  end

  def sort(builds)
    out = build_mappings.map { |mapping|
      builds.find { |b| b.name == mapping.from }
    }

    out += builds
    out.uniq
  end

  def with_pending(builds)
    build_mappings.each do |mapping|
      unless builds.map(&:name).include?(mapping.from)
        builds << build(mapping.from, "pending")
      end
    end

    builds
  end

  def build(name, status)
    Build.new(name: name, status: status)
  end

  def build_mappings
    revision.build_mappings
  end
end
