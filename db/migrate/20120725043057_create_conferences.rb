class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :address
      t.references :state

      t.timestamps
    end
    add_index :conferences, :state_id
  end
end
