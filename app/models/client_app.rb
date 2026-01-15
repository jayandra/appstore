class ClientApp < ApplicationRecord
  belongs_to :user
  has_one_attached :image_filename
end
