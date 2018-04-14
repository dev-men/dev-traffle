class CreateAdminNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_notifications do |t|
      t.text :description
      t.integer :category
      t.boolean :read, :default => false
      t.references :admin, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
