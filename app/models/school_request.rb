class SchoolRequest < ActiveRecord::Base
   
  attr_accessible  :state, :school

  validates_presence_of :state
  validates :school, :presence => true

end
