class ChangeTimeToStartTimeInSchedules < ActiveRecord::Migration
  def change
    rename_column :schedules, :time, :start_time
  end
end
