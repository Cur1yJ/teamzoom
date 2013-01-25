# == Schema Information
#
# Table name: archives
#
#  id            :integer          not null, primary key
#  bucket_id     :integer
#  recording_id  :integer
#  file_name     :string(255)
#  file_format   :string(255)
#  file_date     :datetime
#  status        :integer
#  last_modified :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Archive < ActiveRecord::Base
  belongs_to :recording
  attr_accessible :bucket_id, :file_date, :file_format, :file_name, :last_modified, :recording_id, :status
end
