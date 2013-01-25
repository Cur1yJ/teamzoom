class AddFieldToOrder < ActiveRecord::Migration
  def change
    remove_column :users, :total_price
    add_column :orders, :total_price, :decimal
  end
end
