class AddEndTimeToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :end_time, :datetime
  end
end
