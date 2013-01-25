# == Schema Information
#
# Table name: subteams
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  name         :string(255)
#  image        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  teamsport_id :integer
#

class Subteam < ActiveRecord::Base
	belongs_to :team
	belongs_to :team_opponent, :class_name => "Team", :foreign_key => "team_id"
	has_many :schedules_homes, :class_name => "Schedule", :foreign_key => "subteam_id"
	has_many :schedules_opponents, :class_name => "Schedule", :foreign_key => "opponent_id"
  attr_accessible :image, :name, :team_id, :teamsport_id
	belongs_to :teamsport
	has_many :schedules
	validates_uniqueness_of :name, :scope => :teamsport_id
end
