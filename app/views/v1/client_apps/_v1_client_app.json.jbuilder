json.extract! client_app, :id, :name, :tagline
json.image_url client_app.image_filename.attached? ? rails_blob_url(client_app.image_filename) : nil
