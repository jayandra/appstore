# require "test_helper"

# class UserTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end
require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123",
      status: "active",
      failed_attempts: 0,
      first_failed_at: nil,
      locked_at: nil
    )
  end

  test "user can authenticate if not locked" do
    assert @user.can_authenticate?
  end

  test "back-to-back login failures locks the user" do
    5.times do
      @user.track_failed_login
    end

    assert @user.locked?
  end

  test "Locked user can be unlocked after UNLOCK_WINDOW" do
    5.times do
      @user.track_failed_login
    end
    assert @user.locked?

    @user.locked_at = Time.current - 1.hour
    @user.unlock_if_expired
    assert @user.active?
    assert_equal @user.failed_attempts, 0
    assert_nil @user.first_failed_at
    assert_nil @user.locked_at
  end
end
