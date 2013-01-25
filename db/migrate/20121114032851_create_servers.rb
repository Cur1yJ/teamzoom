class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :server_uri
      t.string :server_zone
      t.integer :status
      t.datetime :last_modified

      t.timestamps
    end
  end
end
