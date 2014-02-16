class BuildPresenter
  pattr_initialize :source_builds, :build_mappings

  def list
    builds = with_pending(source_builds)
    builds = sort(builds)
    builds.map { |build|
      mapping = mapping_for_build(build)
      name = mapping ? mapping.to : build.name
      status = build.status
      new_build(name, status)
    }
  end

  private

  def with_pending(builds)
    pending_mappings = build_mappings.select { |mapping|
      pending_build?(builds, mapping)
    }

    pending_builds = pending_mappings.map { |mapping|
      new_build(mapping.from, "pending")
    }

    builds + pending_builds
  end

  def sort(builds)
    mapped_builds = build_mappings.map { |mapping|
      build_for_mapping(builds, mapping)
    }

    (mapped_builds + builds).uniq
  end

  def pending_build?(builds, mapping)
    !builds.map(&:name).include?(mapping.from)
  end

  def build_for_mapping(builds, mapping)
    builds.find { |b| b.name == mapping.from }
  end

  def mapping_for_build(build)
    build_mappings.find { |m| m.from == build.name }
  end

  def new_build(name, status)
    Build.new(name: name, status: status)
  end
end
