class AddUsTimezoneToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :us_timezone, :string, :default => "Eastern Time (US & Canada)"
  end
end
