class Api::BuildStatusesController < ApiController
  before_filter :check_token

  def create
    UpdateBuildStatus.run(
      params[:name],
      params[:repository],
      params[:revision],
      params[:status],
      params[:status_url],
    )
    render nothing: true
  end

  private

  def check_token
    render nothing: true, status: :unauthorized unless App.api_token == params[:token]
  end
end
