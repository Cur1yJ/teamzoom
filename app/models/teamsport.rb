# == Schema Information
#
# Table name: teamsports
#
#  id                      :integer          not null, primary key
#  sport_id                :integer
#  team_id                 :integer
#  name                    :string(255)
#  logo_image_file_name    :string(255)
#  logo_image_content_type :string(255)
#  logo_image_file_size    :integer
#  logo_image_updated_at   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Teamsport < ActiveRecord::Base
  belongs_to :sport
  belongs_to :team
  has_many :subteams, :dependent => :destroy
  # has_many :venues
  accepts_nested_attributes_for :subteams, :allow_destroy => true, :reject_if => lambda{|v| v[:name].blank?}
  # accepts_nested_attributes_for :venues, :allow_destroy => true, :reject_if => lambda{|v| v[:venue].blank?}

  attr_accessible :sport_id, :team_id, :subteams_attributes, :venues_attributes

  validates_associated :subteams
end
