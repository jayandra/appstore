require "test_helper"

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user with valid data" do
    assert_difference("User.count") do
      post v1_users_create_url, params: {
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      }, as: :json
    end
    assert_response :created
    assert_not_nil JSON.parse(response.body)["uuid"]
  end

  test "should not create user with invalid email" do
    assert_no_difference("User.count") do
      post v1_users_create_url, params: {
        email: "invalid_email",
        password: "password123",
        password_confirmation: "password123"
      }, as: :json
    end
    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)["errors"], "Email is invalid"
  end

  test "should destroy user with valid uuid" do
    user = users(:one) # Assuming you have a fixture with user named 'one'
    assert_difference("User.count", -1) do
      delete v1_user_destroy_url(uuid: user.uuid)
    end
    assert_response :no_content
  end

  test "should return not found for invalid uuid" do
    delete v1_user_destroy_url(uuid: "non-existent-uuid")
    assert_response :not_found
  end
end
