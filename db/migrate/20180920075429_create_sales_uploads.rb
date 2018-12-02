class CreateSalesUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_uploads do |t|
      t.string :video

      t.timestamps
    end
  end
end
