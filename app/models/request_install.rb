class RequestInstall < ActiveRecord::Base
 
   attr_accessible   :name, :email, :school, :state, :zip_code, :phone, :city, :address, :learnabout
   
  #validates_presence_of :name
  #validates_presence_of :email
  validates_presence_of :school
  validates_presence_of :state
  #validates_presence_of :zip_code
  
  regex = /^[a-zA-Z]/
  validates :name,:format => {  :with => regex  ,:message=>"-Please enter string only"}
  validates_format_of :email,:presence => true,:with=>  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message=>"-Please enter correct email"  
  
  validates_format_of :zip_code, :presence => true,:with => %r{\d{5}(-\d{4})?},:message => "should be 12345 or 12345-1234"

  #validates_length_of :phone, :within => 7..10, :message => "Please enter a telephone number that 10 digits long."
end
