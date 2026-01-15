class ClientAppsController < ApplicationController
  before_action :set_client_app, only: %i[ show update destroy ]

  # GET /client_apps
  # GET /client_apps.json
  def index
    @client_apps = ClientApp.all
  end

  # GET /client_apps/1
  # GET /client_apps/1.json
  def show
  end

  # POST /client_apps
  # POST /client_apps.json
  def create
    @client_app = ClientApp.new(client_app_params)

    if @client_app.save
      render :show, status: :created, location: @client_app
    else
      render json: @client_app.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client_apps/1
  # PATCH/PUT /client_apps/1.json
  def update
    if @client_app.update(client_app_params)
      render :show, status: :ok, location: @client_app
    else
      render json: @client_app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client_apps/1
  # DELETE /client_apps/1.json
  def destroy
    @client_app.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_app
      @client_app = ClientApp.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def client_app_params
      params.expect(client_app: [ :name, :tagline, :image_url, :user_id ])
    end
end
