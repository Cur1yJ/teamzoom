class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on
      t.string :address1
      t.string :address2
      t.string :state
      t.string :city
      t.string :zip_code

      t.timestamps
    end
  end
end

