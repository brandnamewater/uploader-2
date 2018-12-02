class RemoveAddressFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :address, :string
    remove_column :orders, :city, :string
    remove_column :orders, :state, :string
  end
end
