class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :server_id
      t.integer :log_type
      t.text :log_message
      t.datetime :log_time
      t.integer :status
      t.datetime :last_modified

      t.timestamps
    end
  end
end
