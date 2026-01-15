class V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :me ]
  def create
    @user = User.new(user_params)
    if @user.save
      render template: "v1/users/create", status: :created
    else
      render template: "v1/users/error", status: :unprocessable_entity
    end
  end

  def destroy
     @user = User.find_by(uuid: params["uuid"])
     begin
      @user.destroy
      head :no_content
     rescue
      render json: { errors: [ "No matching user found" ] }, status: :not_found
     end
  end

  def login
    @user = User.find_by(email: params[:email])
    @application = Doorkeeper::Application.first || Doorkeeper::Application.new(name: "testapp", secret: "testapp", redirect_uri: "https://localhost.com")

    if @user && @user.authenticate(params[:password])
      @user.unlock_if_expired

      if @user.can_authenticate?
        token_response = Doorkeeper::OAuth::PasswordAccessTokenRequest.new(
          Doorkeeper.configuration,
          Doorkeeper::OAuth::Client.new(@application),
          Doorkeeper::OAuth::Client::Credentials.new(params[:email], params[:password]),
          @user
        ).authorize
        @token = token_response.token
        render "v1/users/login", status: :ok
      else
        render json: { errors: [ "Account is locked" ] }, status: :unauthorized
      end
    else
      @user.track_failed_login  if @user

      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end

  # Protected endpoint - requires authentication
  def me
    @user = current_user
    render "v1/users/me", status: :ok
  end

  private
  def user_params
    permitted = params.slice(:email, :password, :password_confirmation).permit!
    permitted.to_h.symbolize_keys
  end
end
