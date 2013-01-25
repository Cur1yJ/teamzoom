class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :venue
      t.string :url
      t.references :teamsport

      t.timestamps
    end
    add_index :venues, :teamsport_id
  end
end
