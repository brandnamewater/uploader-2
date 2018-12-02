class AddSellerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :seller, :boolean, default: false
  end
end
