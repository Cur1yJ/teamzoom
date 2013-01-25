# == Schema Information
#
# Table name: sports
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  imgage      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean
#

class Sport < ActiveRecord::Base
  has_many :teamsports
  has_many :teams , :through => :teamsports

  attr_accessible :description, :imgage, :name, :active
  has_one :schedule

  validates :name, :presence => true, :uniqueness => true
  
  scope :active, lambda {where(:active => true)}
end
