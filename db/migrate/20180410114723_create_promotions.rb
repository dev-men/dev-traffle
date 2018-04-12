class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.text :message
      t.string :subject
      t.timestamps
    end
  end
end
