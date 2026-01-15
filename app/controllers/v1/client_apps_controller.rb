class V1::ClientAppsController < ApplicationController
  before_action :set_client_app, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]

  # GET /v1/client_apps
  # GET /v1/client_apps.json
  def index
    if params[:filter].blank?
      @client_apps = ClientApp.all
    else
      @client_apps = ClientApp.where("name LIKE ? or tagline LIKE ?", "%#{params[:filter]}%", "%#{params[:filter]}%")
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
    if @client_app.update(v1_client_app_params)
      render :show, status: :ok, location: v1_client_app_url(@client_app.reload)
    else
      render json: @client_app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/client_apps/1
  # DELETE /v1/client_apps/1.json
  def destroy
    @client_app.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_app
      @client_app = ClientApp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_client_app_params
      params.permit(:id, :name, :tagline, :image_filename, :filter)
    end
end
