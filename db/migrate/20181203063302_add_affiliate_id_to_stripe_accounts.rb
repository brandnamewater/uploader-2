class AddAffiliateIdToStripeAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_accounts, :affiliate_id, :integer
  end
end
