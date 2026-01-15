class ApplicationController < ActionController::API
  wrap_parameters false

  # Use this in controllers that need authentication
  def authenticate_user!
    doorkeeper_authorize!
    head :unauthorized unless current_user
  end

  def current_user
    User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
