class CreateNewsLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :news_letters do |t|
      t.string :email
      t.string :name
      t.boolean :status, :default => true
      t.timestamps
    end
  end
end
