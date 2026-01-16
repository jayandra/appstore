class ClientApp < ApplicationRecord
  belongs_to :user
  has_one_attached :image_filename

  after_commit :invalidate_cache, only: [ :update, :destroy ]

  def invalidate_cache
    # Delete cache for current record
    Rails.cache.delete("v1_client_app_#{id}")

    # If this is an update, grab original updated_at and delete cache for it
    if previous_changes[:updated_at] && previous_changes[:updated_at].first
      previous_updated_at = previous_changes[:updated_at].first
      Rails.cache.delete("v1_client_app_json_#{previous_updated_at}")
    end
  end
end
