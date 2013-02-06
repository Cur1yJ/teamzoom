

# == Schema Information
#
# Table name: recordings
#
#  id             :integer          not null, primary key
#  schedule_id    :integer
#  stream_name    :string(255)
#  recording_name :string(255)
#  start_time     :datetime
#  end_time       :datetime
#  status         :integer
#  last_modified  :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Recording < ActiveRecord::Base

  belongs_to :schedule
  has_one :archive
  
  DONE = 1
  IN_PROCESS = 2
  
  attr_accessible :end_time, :last_modified, :recording_name, :schedule_id, :start_time, :status, :stream_name

 end
