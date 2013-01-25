class AddCancelToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cancel, :boolean, :default => false
  end
end
