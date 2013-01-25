# == Schema Information
#
# Table name: team_managements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeamManagement < ActiveRecord::Base
#------------------------------------------------------------------------------
#  Description:
#             same comment with team model
#------------------------------------------------------------------------------
    attr_accessible :user_id, :team_id
    belongs_to :team
    belongs_to :user
    
end
