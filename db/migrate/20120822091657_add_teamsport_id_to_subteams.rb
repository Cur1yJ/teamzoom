class AddTeamsportIdToSubteams < ActiveRecord::Migration
  def change
    add_column :subteams, :teamsport_id, :integer
  end
end
