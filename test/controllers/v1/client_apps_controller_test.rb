require "test_helper"

class V1::ClientAppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @v1_client_app = client_apps(:one)
  end

  test "should get index" do
    get v1_client_apps_url, as: :json
    assert_response :success
  end

  test "should create v1_client_app" do
    assert_difference("ClientApp.count") do
      post v1_client_apps_url, params: { client_app: { image_url: @v1_client_app.image_url, name: @v1_client_app.name, tagline: @v1_client_app.tagline, user_id: @v1_client_app.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show v1_client_app" do
    get v1_client_app_url(@v1_client_app), as: :json
    assert_response :success
  end

  test "should update v1_client_app" do
    patch v1_client_app_url(@v1_client_app), params: { client_app: { image_url: @v1_client_app.image_url, name: @v1_client_app.name, tagline: @v1_client_app.tagline, user_id: @v1_client_app.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy v1_client_app" do
    assert_difference("ClientApp.count", -1) do
      delete v1_client_app_url(@v1_client_app), as: :json
    end

    assert_response :no_content
  end
end
