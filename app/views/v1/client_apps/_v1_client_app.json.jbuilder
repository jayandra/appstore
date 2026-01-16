json.cache! "v1_client_app_json#{client_app.updated_at}", expires_in: 30.minutes do
  json.extract! client_app, :id, :name, :tagline
  json.image_url client_app.image_filename.attached? ? client_app.image_filename.url(expires_in: 1.week) : nil
end
