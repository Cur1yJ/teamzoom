class AddRecordingNameToSchedules < ActiveRecord::Migration
  def up
    add_column :schedules, :recording_name, :string
  end

  def down
    remove_column :schedules, :recording_name
  end
end
