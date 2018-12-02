class AddCvcToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cvc, :integer
  end
end
