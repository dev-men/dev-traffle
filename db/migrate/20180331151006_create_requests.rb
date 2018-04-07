class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.boolean :status, default: false
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
