class AddPhoneNumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :phone_number, :string
  end
end
