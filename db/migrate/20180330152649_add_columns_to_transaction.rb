class AddColumnsToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :paystack_transaction_id, :string
    add_column :transactions, :access_code, :string
  end
end
