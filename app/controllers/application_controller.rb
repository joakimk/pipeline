class ApplicationController < ActionController::Base
  force_ssl if: :production?

  private

  def repository
    App.repository
  end

  def production?
    Rails.env.production?
  end
end
