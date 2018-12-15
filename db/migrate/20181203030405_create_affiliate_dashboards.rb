class CreateAffiliateDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliate_dashboards do |t|
      t.string :clients
      t.string :analytics
      t.string :orders

      t.timestamps
    end
  end
end
