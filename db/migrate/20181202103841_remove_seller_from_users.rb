class RemoveSellerFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :seller, :integer
  end
end
