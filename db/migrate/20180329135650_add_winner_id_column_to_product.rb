class AddWinnerIdColumnToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :winner_id, :integer
  end
end
