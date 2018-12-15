class AddCommissionToAffiliates < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :commission, :decimal, null: false, default: 0.05
  end
end
