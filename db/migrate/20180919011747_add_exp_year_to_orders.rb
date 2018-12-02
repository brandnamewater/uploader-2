class AddExpYearToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :exp_year, :integer
  end
end
