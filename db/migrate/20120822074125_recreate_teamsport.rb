class RecreateTeamsport < ActiveRecord::Migration
  def up
		drop_table :teamsports
		create_table :teamsports do |t|
			t.integer :sport_id
			t.integer :team_id
			t.string :name
			t.attachment :logo_image

			t.timestamps
		end
		add_index :teamsports, :sport_id
		add_index :teamsports, :team_id
  end

  def down
		drop_table :teamsports
		create_table :teamsports do |t|
			t.integer :sport_id
			t.integer :team_id

			t.timestamps
		end
  end
end
