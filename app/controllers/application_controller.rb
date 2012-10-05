class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl :if => :production?

  def production?
    Rails.env.production?
  end
end
