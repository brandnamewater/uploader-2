class AddOrderIdToSalesUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_uploads, :order_id, :integer
  end
end
