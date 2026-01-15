class ClientAppsRenameImageUrlToImageFilename < ActiveRecord::Migration[8.0]
  def change
    rename_column :client_apps, :image_url, :image_filename
  end
end
