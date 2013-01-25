class CreateS3Buckets < ActiveRecord::Migration
  def change
    create_table :s3_buckets do |t|
      t.string :s3_url
      t.string :s3_zone
      t.string :s3_permission
      t.integer :status
      t.datetime :last_modified

      t.timestamps
    end
  end
end
