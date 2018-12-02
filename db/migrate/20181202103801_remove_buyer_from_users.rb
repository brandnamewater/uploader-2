class RemoveBuyerFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :buyer, :integer
  end
end
