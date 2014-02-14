class ApplicationController < ActionController::Base
  force_ssl if: :production?

  private

  def production?
    Rails.env.production?
  end
end
