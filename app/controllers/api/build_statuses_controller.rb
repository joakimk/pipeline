require "httparty"

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

    Thread.new do
      webhook_url = ENV.fetch("WEBHOOK_URL", nil)

      if webhook_url
        HTTParty.post(webhook_url, body: { payload: ProjectStatusSerializer.new(project).serialize.to_json }, timeout: 10)
      end
    end

    render nothing: true
  end
end
