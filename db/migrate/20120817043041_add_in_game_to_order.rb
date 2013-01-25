class AddInGameToOrder < ActiveRecord::Migration
  def change
    remove_column :users, :individual_game
    add_column :orders, :individual_game, :boolean, :default => false
  end
end
