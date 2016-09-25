class ApiController < ApplicationController
  before_filter :check_token

  def check_token
    render nothing: true, status: :unauthorized unless App.api_token == params[:token]
  end
end
