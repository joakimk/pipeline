class Api::BuildStatusesController < ApiController
  before_filter :check_token

  def create
    UpdateBuildStatus.run(repository, clean_params)
    render nothing: true
  end

  private

  def check_token
    render nothing: true, status: :unauthorized unless App.api_token == params[:token]
  end

  def clean_params
    params.except(:action, :controller, :token)
  end
end
