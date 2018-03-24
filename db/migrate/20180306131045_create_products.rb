class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :category
      t.integer :total_tickets
      t.integer :sold_tickets, :default => 0
      t.text :short_description
      t.text :long_description
      t.boolean :approve, :default => false
      t.datetime :count_down
      t.boolean :hot, :default => false
      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
