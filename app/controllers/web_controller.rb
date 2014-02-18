require 'slim'
require 'bootstrap_forms'

class WebController < ApplicationController
  protect_from_forgery

  before_filter :temporary_security
  before_filter :setup_menu

  private

  def active_menu_item_name(name)
    @active_menu_item_name = name
  end

  def temporary_security
    return unless Rails.env.production?

    raise 'Need pw configured in prod.' unless ENV['TEMP_PW']

    # NOTE: Also used in app/middleware/push_backend
    if !session[:logged_in] && params[:pw] != ENV['TEMP_PW']
      render text: ''
    else
      session[:logged_in] = true
    end
  end
end
