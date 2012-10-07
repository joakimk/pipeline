class Api::StatusesController < ApiController
  before_filter :check_token

  def create
    update_status.with(clean_params)
    render nothing: true
  end

  private

  def update_status
    UseCase::UpdateStatus.new(repository)
  end

  def check_token
    render nothing: true, status: :unauthorized unless App.api_token == params[:token]
  end

  def clean_params
    params.reject { |k, v| [ :action, :controller, :token ].include?(k.to_sym) }
  end
end
