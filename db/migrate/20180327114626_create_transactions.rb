class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :reference
      t.string :amount
      t.string :email
      t.string :paystack_transaction_id
      t.string :access_code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
