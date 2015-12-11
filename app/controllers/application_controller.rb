class ApplicationController < ActionController::Base
  force_ssl if: :production?

  private

  def production?
    Rails.env.production?
  end

  def locals(action = nil, hash)
    render action: action, locals: hash
  end
end
