class AddOrderPriceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_price, :decimal
  end
end
