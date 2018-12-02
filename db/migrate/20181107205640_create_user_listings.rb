class CreateUserListings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_listings do |t|

      t.timestamps
    end
  end
end
