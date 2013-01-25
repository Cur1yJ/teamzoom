class AddFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :school_id, :integer
    add_column :orders, :team_id, :integer
    add_column :orders, :tax, :decimal
  end
end
