class AddAffiliateIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :affiliate_id, :integer
  end
end
