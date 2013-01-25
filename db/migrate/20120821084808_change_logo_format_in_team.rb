class ChangeLogoFormatInTeam < ActiveRecord::Migration
  def change
		add_attachment :teams, :logo_image
	end
end
