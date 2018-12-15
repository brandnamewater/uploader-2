class AddCommissionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :commission, :decimal, null: false, default: 0.75
  end
end
