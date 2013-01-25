# == Schema Information
#
# Table name: schools
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  address       :string(255)
#  conference_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class School < ActiveRecord::Base
  belongs_to :conference
  attr_accessible :address, :name, :conference_id, :teams_attributes, :conference_attributes
  has_many :teams
  accepts_nested_attributes_for :teams, :conference
  validates :name, :conference_id, :presence => true
  validates :name, :uniqueness => true
end
