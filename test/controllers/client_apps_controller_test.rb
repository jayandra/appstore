require "test_helper"

class ClientAppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_app = client_apps(:one)
  end

  test "should get index" do
    get client_apps_url, as: :json
    assert_response :success
  end

  test "should create client_app" do
    assert_difference("ClientApp.count") do
      post client_apps_url, params: { client_app: { image_url: @client_app.image_url, name: @client_app.name, tagline: @client_app.tagline, user_id: @client_app.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show client_app" do
    get client_app_url(@client_app), as: :json
    assert_response :success
  end

  test "should update client_app" do
    patch client_app_url(@client_app), params: { client_app: { image_url: @client_app.image_url, name: @client_app.name, tagline: @client_app.tagline, user_id: @client_app.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy client_app" do
    assert_difference("ClientApp.count", -1) do
      delete client_app_url(@client_app), as: :json
    end

    assert_response :no_content
  end
end
