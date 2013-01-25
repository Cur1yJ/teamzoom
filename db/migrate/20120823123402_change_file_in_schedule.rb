class ChangeFileInSchedule < ActiveRecord::Migration
  def change 
    remove_column :schedules, :location
    add_column :schedules, :venue_id, :integer
  end
end
