class AddTwoColumnsToRecipients < ActiveRecord::Migration[5.1]
  def change
    add_column :recipients, :recipient_code, :string
    add_column :recipients, :paystack_recipient_id, :string
  end
end
