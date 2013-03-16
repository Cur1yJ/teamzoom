class AddVenueUrlInSchedules < ActiveRecord::Migration
  def up
    add_column :schedules, :venue_url, :string
  end

  def down
    remove_column :schedules, :venue_url
  end
end
