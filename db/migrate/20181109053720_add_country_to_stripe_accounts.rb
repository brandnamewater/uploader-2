class AddCountryToStripeAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_accounts, :country, :string
  end
end
