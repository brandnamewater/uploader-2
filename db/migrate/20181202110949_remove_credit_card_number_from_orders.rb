class RemoveCreditCardNumberFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :credit_card_number, :integer
  end
end
