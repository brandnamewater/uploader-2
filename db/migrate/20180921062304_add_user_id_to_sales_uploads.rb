class AddUserIdToSalesUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_uploads, :user_id, :integer
  end
end
