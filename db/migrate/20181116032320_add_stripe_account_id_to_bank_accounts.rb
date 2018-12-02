class AddStripeAccountIdToBankAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :bank_accounts, :stripe_account_id, :integer
  end
end
