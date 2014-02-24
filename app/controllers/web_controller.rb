require 'slim'
require 'bootstrap_forms'

class WebController < ApplicationController
  protect_from_forgery

  before_filter :require_password
  before_filter :setup_menu

  private

  def active_menu_item_name(name)
    @active_menu_item_name = name
  end

  def require_password
    return unless Rails.env.production?

    raise "Need WEB_PASSWORD configured in prod." unless ENV['WEB_PASSWORD']

    if !session[:logged_in] && params[:pw] != ENV['WEB_PASSWORD']
      render text: ''
    else
      session[:logged_in] = true
    end
  end
end
