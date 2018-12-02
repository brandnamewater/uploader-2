class AddNameToBuyers < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :name, :string
  end
end
