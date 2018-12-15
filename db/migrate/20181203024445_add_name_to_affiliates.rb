class AddNameToAffiliates < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :name, :string
  end
end
