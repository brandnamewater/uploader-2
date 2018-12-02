class AddBuyerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :buyer, :boolean, default: true
  end
end
