class Api::BuildsController < ApiController
  def lock
    locked_by_revision = build_lock.take(revision)
    render json: { build_locked_by: locked_by_revision }
  end

  def unlock
    build_lock.release(revision)
    render nothing: true
  end

  private

  def build_lock
    BuildLock.new(repository, build_name)
  end

  def repository
    params[:repository]
  end

  def revision
    params[:revision]
  end

  def build_name
    params[:name]
  end
end
