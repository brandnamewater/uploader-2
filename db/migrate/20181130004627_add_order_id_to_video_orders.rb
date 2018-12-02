class AddOrderIdToVideoOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :video_orders, :order_id, :integer
  end
end
