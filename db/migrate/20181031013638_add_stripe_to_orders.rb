class AddStripeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :stripe_customer_token, :string
  end
end
