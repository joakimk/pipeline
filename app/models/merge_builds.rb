require "build_status"

class MergeBuilds
  method_object :builds

  include BuildStatus

  def call
    statuses = builds.map(&:status)

    if statuses.include?(BUILDING)
      merge(builds, as: BUILDING)
    elsif statuses.include?(PENDING)
      merge(builds, as: PENDING)
    elsif statuses.include?(FIXED)
      merge(builds, as: FIXED)
    elsif statuses.uniq.sort == [ FAILED, SUCCESSFUL ]
      merge(builds, as: FAILED)
    else
      merge(builds)
    end
  end

  private

  def merge(builds, as: builds.first.status)
    build = builds.first.dup
    build.name = builds.map(&:name).uniq.join("_and_")
    build.status = as
    build
  end
end
