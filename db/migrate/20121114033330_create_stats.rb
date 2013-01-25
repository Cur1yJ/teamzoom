class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :schedule_id
      t.datetime :stat_time
      t.integer :stat_type  # 1-viewers 2-servers 3-streams 4-recordings ...
      t.integer :stat_count

      t.timestamps
    end
  end
end
