class AddVideoToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :video, :string
  end
end
