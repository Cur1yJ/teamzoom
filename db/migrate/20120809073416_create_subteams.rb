class CreateSubteams < ActiveRecord::Migration
  def change
    create_table :subteams do |t|
      t.integer :team_id
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
