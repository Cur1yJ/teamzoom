class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :subteam_id
      t.integer :opponent
      t.integer :sport_id
      t.string  :location
      t.string  :time
      t.date  :date

      t.timestamps
    end
  end
end
