# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  state      :string(255)
#  team       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Request < ActiveRecord::Base
  attr_accessible :state, :team
  validates_presence_of :state 
  validates_presence_of :team 
  validates :team, :length => {:minimum => 1, :maximum => 254 }
end
