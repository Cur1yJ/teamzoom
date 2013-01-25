class AddLogoToTeamsPaperclip < ActiveRecord::Migration
  def up
    remove_column :teams, :logo
    add_column :teams, :logo_file_name,    :string
    add_column :teams, :logo_content_type, :string
    add_column :teams, :logo_file_size,    :integer
    add_column :teams, :logo_updated_at,   :datetime
  end
  def down
    remove_column :teams, :logo_file_name
    remove_column :teams, :logo_content_type
    remove_column :teams, :logo_file_size
    remove_column :teams, :logo_updated_at
    add__column :teams, :logo    
  end
end
