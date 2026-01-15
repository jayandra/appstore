json.extract! client_app, :id, :name, :tagline, :image_url, :user_id, :created_at, :updated_at
json.url client_app_url(client_app, format: :json)
