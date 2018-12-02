class AddOrderStatusToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_status, :integer, default: true
  end
end
