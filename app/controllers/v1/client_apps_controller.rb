class V1::ClientAppsController < ApplicationController
  before_action :set_client_app, only: %i[ show update destroy ]

  # GET /v1/client_apps
  # GET /v1/client_apps.json
  def index
    @v1_client_apps = ClientApp.all
  end

  # GET /v1/client_apps/1
  # GET /v1/client_apps/1.json
  def show
  end

  # POST /v1/client_apps
  # POST /v1/client_apps.json
  def create
    @v1_client_app = ClientApp.new(v1_client_app_params)

    if @v1_client_app.save
      render :show, status: :created, location: v1_client_app_url(@v1_client_app)
    else
      render json: @v1_client_app.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/client_apps/1
  # PATCH/PUT /v1/client_apps/1.json
  def update
    if @v1_client_app.update(v1_client_app_params)
      render :show, status: :ok, location: v1_client_app_url(@v1_client_app)
    else
      render json: @v1_client_app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/client_apps/1
  # DELETE /v1/client_apps/1.json
  def destroy
    @v1_client_app.destroy!
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_app
      @v1_client_app = ClientApp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_client_app_params
      params.require(:client_app).permit(:name, :tagline, :image_url, :user_id)
    end
end
