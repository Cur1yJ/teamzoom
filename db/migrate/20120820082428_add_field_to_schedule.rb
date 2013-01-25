class AddFieldToSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :time
    remove_column :schedules, :date
    add_column :schedules, :time, :datetime
    add_column :schedules, :event_date, :datetime
    rename_column :schedules, :opponent, :opponent_id
    add_column :schedules, :score_home, :float
    add_column :schedules, :score_opponent, :float
  end
end
