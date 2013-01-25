class RemoveTeamsportIdFromVenues < ActiveRecord::Migration
  def change
		remove_column :venues, :teamsport_id
    add_column :venues, :team_id, :integer
  end
end
