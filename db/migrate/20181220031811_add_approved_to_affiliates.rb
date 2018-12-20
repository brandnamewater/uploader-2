class AddApprovedToAffiliates < ActiveRecord::Migration[5.2]
  def self.up
    add_column :affiliates, :approved, :boolean, :default => false, :null => false
    add_index  :affiliates, :approved
  end

  def self.down
    remove_index  :affiliates, :approved
    remove_column :affiliates, :approved
  end
end
