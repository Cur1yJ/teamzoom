class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.integer :schedule_id
      t.string :stream_name
      t.string :recording_name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status
      t.datetime :last_modified

      t.timestamps
    end
  end
end
