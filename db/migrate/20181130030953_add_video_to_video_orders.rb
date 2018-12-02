class AddVideoToVideoOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :video_orders, :video, :string
  end
end
