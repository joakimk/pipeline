require "active_support/core_ext/module/delegation"
require "merge_builds"

class BuildPresenter
  pattr_initialize :revision

  def list
    builds = revision.builds
    builds = add_pending(builds)
    builds = change_status_for_fixed_builds(builds)
    builds = sort_by_mappings(builds)
    builds = apply_mappings(builds)
    merge_builds_with_the_same_name(builds)
  end

  private

  delegate :build_mappings,
    to: :revision

  def add_pending(builds)
    pending_mappings = build_mappings.select { |mapping|
      pending_build?(builds, mapping)
    }

    pending_builds = pending_mappings.map { |mapping|
      new_build(mapping.from, BuildStatus::PENDING)
    }

    builds + pending_builds
  end

  def change_status_for_fixed_builds(builds)
    builds.map { |build|
      if newer_revision_fixes?(build)
        new_build(build.name, BuildStatus::FIXED, build)
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

  def apply_mappings(builds)
    builds.map { |build|
      name = mapping_for_build(build).to
      status = build.status
      new_build(name, status, build)
    }
  end

  def merge_builds_with_the_same_name(builds)
    builds.group_by(&:name).flat_map { |_, builds|
      MergeBuilds.call(builds)
    }
  end

  def pending_build?(builds, mapping)
    !builds.map(&:name).include?(mapping.from)
  end

  def build_for_mapping(builds, mapping)
    builds.find { |b| b.name == mapping.from }
  end

  def mapping_for_build(build)
    build_mappings.find { |m| m.from == build.name } ||
      BuildMapping.new(build.name, build.name)
  end

  def newer_revision_fixes?(build)
    return false unless build.status == BuildStatus::FAILED

    newer_revisions = revision.newer_revisions

    newer_revisions.any? &&
      newer_revisions.any? { |r|
        newer_build = r.builds.find { |b| b.name == build.name }
        newer_build && newer_build.status == BuildStatus::SUCCESSFUL
      }
  end

  def new_build(name, status, old_build = nil)
    build = old_build ? old_build.dup : Build.new
    build.name = name
    build.status = status
    build
  end
end
