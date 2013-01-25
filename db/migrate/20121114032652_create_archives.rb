class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :bucket_id
      t.integer :recording_id
      t.string :file_name
      t.string :file_format
      t.datetime :file_date
      t.integer :status
      t.datetime :last_modified

      t.timestamps
    end
  end
end
