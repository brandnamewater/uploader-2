class CreateStripeAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :stripe_accounts do |t|

      t.timestamps
    end
  end
end
