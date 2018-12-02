class CreateVideoOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :video_orders do |t|

      t.timestamps
    end
  end
end
