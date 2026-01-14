class User < ApplicationRecord
  has_secure_password

  enum :status, { active: 0, locked: 1, disabled: 2 }, default: :active
  UNLOCK_WINDOW = 30.minutes
  FAILURE_WINDOW = 5.minutes
  ALLOWED_FAILURES = 5

  def can_authenticate?
    active? && locked_at.nil?
  end

  def track_failed_login
    current_time = Time.current

    with_lock do
      if first_failed_at.nil? || first_failed_at < FAILURE_WINDOW.ago
        self.first_failed_at = current_time
        self.failed_attempts = 1
      else
        self.failed_attempts += 1
      end

      if self.failed_attempts >= ALLOWED_FAILURES
        self.status = "locked"
        self.locked_at = current_time
      end

      save!
    end
  end

  def unlock_if_expired
    if locked_at && locked_at < UNLOCK_WINDOW.ago
      self.failed_attempts = 0
      self.first_failed_at = nil
      self.locked_at = nil
      self.status = "active"
      self.save!
    end
  end
end
