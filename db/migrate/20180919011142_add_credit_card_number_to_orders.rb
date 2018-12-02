class AddCreditCardNumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :credit_card_number, :integer
  end
end
