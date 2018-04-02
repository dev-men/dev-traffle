class CreateRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients do |t|
      t.string :r_type, :default => "nuban"
      t.string :name
      t.text :description
      t.string :account_number
      t.string :bank_code
      t.string :recipient_code
      t.string :paystack_recipient_id
      t.string :currency, :default => "NGN"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
