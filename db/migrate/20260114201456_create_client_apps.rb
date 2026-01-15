class CreateClientApps < ActiveRecord::Migration[8.0]
  def change
    create_table :client_apps do |t|
      t.string :name
      t.string :tagline
      t.string :image_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :client_apps, :name
    add_index :client_apps, :tagline
  end
end
