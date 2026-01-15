class ApplicationController < ActionController::API
  wrap_parameters false

  # Use this in controllers that need authentication
  def authenticate_user!
    doorkeeper_authorize!
    render json: { error: "User not found" }, status: :unauthorized unless current_user
  end

  def current_user
    User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
