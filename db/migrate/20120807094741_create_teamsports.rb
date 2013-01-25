class CreateTeamsports < ActiveRecord::Migration
  def change
    create_table :teamsports do |t|
      t.integer :sport_id
      t.integer :team_id

      t.timestamps
    end
  end
end
