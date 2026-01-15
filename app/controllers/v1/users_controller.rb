class V1::UsersController < ApplicationController
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
      render json: { errors: [ "No matching user found" ] }.to_json, status: :not_found
     end
  end

  private
  def user_params
    permitted = params.slice(:email, :password, :password_confirmation).permit!
    permitted.to_h.symbolize_keys
  end
end
