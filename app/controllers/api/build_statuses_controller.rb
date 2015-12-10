class Api::BuildStatusesController < ApiController
  def create
    project = UpdateBuildStatus.call(
      params[:name],
      params[:repository],
      params[:revision],
      params[:status],
      params[:status_url],
    )

    PushBackend.push({ project_id: project.id,
      html: render_to_string(partial: "projects/project",
                             locals: { project: project }) })
    render nothing: true
  end
end
