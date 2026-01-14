class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :status, default: 0, null: false
      t.integer :failed_attempts, default: 0, null: false
      t.datetime :first_failed_at
      t.datetime :locked_at

      t.timestamps
    end
  end
end
