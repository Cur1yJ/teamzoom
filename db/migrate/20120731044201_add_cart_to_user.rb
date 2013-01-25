class AddCartToUser < ActiveRecord::Migration
  def change
    add_column :users, :purchase_at, :date
    add_column :users, :total_price, :float
    add_column :users, :individual_game, :boolean, :default => false
  end
end

