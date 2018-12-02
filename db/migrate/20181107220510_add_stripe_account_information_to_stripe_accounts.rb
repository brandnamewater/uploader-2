class AddStripeAccountInformationToStripeAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_accounts, :first_name, :string
    add_column :stripe_accounts, :last_name, :string
    add_column :stripe_accounts, :account_type, :string
    add_column :stripe_accounts, :dob_month, :integer
    add_column :stripe_accounts, :dob_day, :integer
    add_column :stripe_accounts, :dob_year, :integer
    add_column :stripe_accounts, :address_city, :string
    add_column :stripe_accounts, :address_state, :string
    add_column :stripe_accounts, :address_line1, :string
    add_column :stripe_accounts, :address_postal, :string
    add_column :stripe_accounts, :tos, :boolean
    add_column :stripe_accounts, :ssn_last_4, :string
    add_column :stripe_accounts, :business_name, :string
    add_column :stripe_accounts, :business_tax_id, :string
    add_column :stripe_accounts, :personal_id_number, :string
    add_column :stripe_accounts, :verification_document, :string
    add_column :stripe_accounts, :acct_id, :string
  end
end
