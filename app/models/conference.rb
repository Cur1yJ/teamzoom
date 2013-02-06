
# == Schema Information
#
# Table name: conferences
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  state_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean
#

class Conference < ActiveRecord::Base

  has_many :schools
  has_many :teams, :through => :schools
  belongs_to :state
  
  attr_accessible :address, :name ,:state_id, :schools_attributes, :state_attributes, :active
 
  validates_presence_of :state_id
  validates :name, :presence => true, :uniqueness => true
  
  accepts_nested_attributes_for :schools, :state
  
  scope :active, lambda {where(:active => true)}
  
end
