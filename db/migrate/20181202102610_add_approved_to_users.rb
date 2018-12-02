class AddApprovedToUsers < ActiveRecord::Migration[5.2]
  def self.up
    add_column :users, :approved, :boolean, :default => true, :null => false
    add_index  :users, :approved
  end

  def self.down
    remove_index  :users, :approved
    remove_column :users, :approved
  end
end
