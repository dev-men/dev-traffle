class AddTicketPriceToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :ticket_price, :float
  end
end
