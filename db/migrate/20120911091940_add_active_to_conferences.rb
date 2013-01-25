class AddActiveToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :active, :boolean
  end
end
