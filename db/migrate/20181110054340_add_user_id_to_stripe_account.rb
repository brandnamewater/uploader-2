class AddUserIdToStripeAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_accounts, :user_id, :integer
  end
end
