require "active_support/core_ext/module/delegation"

class BuildPresenter
  pattr_initialize :revision

  def list
    builds = revision.builds
    builds = add_pending(builds)
    builds = change_status_for_fixed_builds(builds)
    builds = sort_by_mappings(builds)
    map_names(builds)
  end

  private

  delegate :build_mappings,
    to: :revision

  def add_pending(builds)
    pending_mappings = build_mappings.select { |mapping|
      pending_build?(builds, mapping)
    }

    pending_builds = pending_mappings.map { |mapping|
      new_build(mapping.from, "pending")
    }

    builds + pending_builds
  end

  def change_status_for_fixed_builds(builds)
    builds.map { |build|
      if newer_revision_fixes?(build)
        new_build(build.name, "fixed", build)
      else
        build
      end
    }
  end

  def sort_by_mappings(builds)
    mapped_builds = build_mappings.map { |mapping|
      build_for_mapping(builds, mapping)
    }

    (mapped_builds + builds).uniq
  end

  def map_names(builds)
    builds.map { |build|
      mapping = mapping_for_build(build)
      name = mapping ? mapping.to : build.name
      status = build.status
      new_build(name, status, build)
    }
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

  def newer_revision_fixes?(build)
    return false unless build.status == "failed"

    newer_revisions = revision.newer_revisions

    newer_revisions.any? &&
      newer_revisions.any? { |r|
        newer_build = r.builds.find { |b| b.name == build.name }
        newer_build && newer_build.status == "successful"
      }
  end

  def new_build(name, status, old_build = nil)
    build = old_build ? old_build.dup : Build.new
    build.name = name
    build.status = status
    build
  end
end
