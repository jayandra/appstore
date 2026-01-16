class V1::ClientAppsController < ApplicationController
  before_action :set_client_app, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]

  # GET /v1/client_apps
  # GET /v1/client_apps.json
  def index
    @client_apps = Rails.cache.fetch("v1_client_apps_#{params[:filter]}_#{ClientApp.maximum(:updated_at)}", expires_in: 30.minutes) do
      if params[:filter].blank?
        ClientApp.all.to_a
      else
         ClientApp.where("name LIKE ? or tagline LIKE ?", "%#{params[:filter]}%", "%#{params[:filter]}%").to_a
      end
    end
  end

  # GET /v1/client_apps/1
  # GET /v1/client_apps/1.json
  def show
  end

  # POST /v1/client_apps
  # POST /v1/client_apps.json
  def create
    @client_app = current_user.client_apps.new(v1_client_app_params)

    if @client_app.save
      render :show, status: :created, location: v1_client_app_url(@client_app)
    else
      render json: @client_app.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/client_apps/1
  # PATCH/PUT /v1/client_apps/1.json
  def update
    if current_user.client_apps.find_by(id: params[:id])&.update(v1_client_app_params)
      render :show, status: :ok, location: v1_client_app_url(@client_app.reload)
    else
      render json: @client_app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/client_apps/1
  # DELETE /v1/client_apps/1.json
  def destroy
    current_user.client_apps.find_by(id: params[:id])&.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_app
      @client_app = Rails.cache.fetch("v1_client_app_#{params[:id]}") do
        ClientApp.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def v1_client_app_params
      params.permit(:id, :name, :tagline, :image_filename, :filter)
    end
end
