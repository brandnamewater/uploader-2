class RemoveCvcFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :cvc, :integer
  end
end
