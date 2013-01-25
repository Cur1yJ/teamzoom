# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  venue      :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer
#

class Venue < ActiveRecord::Base
  attr_accessible :url, :venue, :team_id
  has_many :schedules
  # belongs_to :teamsport
  belongs_to :team
  validates_uniqueness_of :venue
  validates :venue, :uniqueness => true, :allow_nil => true
end
