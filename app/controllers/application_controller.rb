class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :temporary_security

  force_ssl if: :production?

  def repository
    App.repository
  end

  private

  def production?
    Rails.env.production?
  end

  def temporary_security
    return unless Rails.env.production?
    raise 'Need pw configured in prod.' unless ENV['TEMP_PW']
    if !session[:logged_in] && params[:pw] != ENV['TEMP_PW']
      render text: ''
    else
      session[:logged_in] = true
    end
  end
end
