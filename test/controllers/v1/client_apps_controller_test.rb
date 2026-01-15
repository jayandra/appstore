require "test_helper"

class V1::ClientAppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @v1_client_app = client_apps(:one)
    @user = users(:one)
    @token = generate_token_for(@user)
  end

  def generate_token_for(user)
    application = Doorkeeper::Application.create!(name: "Test App", redirect_uri: "https://example.com")
    Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: user.id)
  end

  test "should get index" do
    get v1_client_apps_url, as: :json
    assert_response :success
  end

  test "should create v1_client_app" do
    assert_difference("ClientApp.count") do
      post v1_client_apps_url,
           params: { name: @v1_client_app.name, tagline: @v1_client_app.tagline },
           headers: { "Authorization" => "Bearer #{@token.token}" },
           as: :json
    end

    assert_response :created
  end

  test "should show v1_client_app" do
    get v1_client_app_url(@v1_client_app), as: :json
    assert_response :success
  end

  test "should update v1_client_app" do
    patch v1_client_app_url(@v1_client_app),
          params: { name: "new name" },
          headers: { "Authorization" => "Bearer #{@token.token}" },
          as: :json
    assert_response :success
  end

  test "should destroy v1_client_app" do
    assert_difference("ClientApp.count", -1) do
      delete v1_client_app_url(@v1_client_app),
             headers: { "Authorization" => "Bearer #{@token.token}" },
             as: :json
    end

    assert_response :no_content
  end
end
