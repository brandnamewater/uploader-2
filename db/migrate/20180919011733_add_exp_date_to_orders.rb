class AddExpDateToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :exp_date, :integer
  end
end
