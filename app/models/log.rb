# == Schema Information
#
# Table name: logs
#
#  id            :integer          not null, primary key
#  server_id     :integer
#  log_type      :integer
#  log_message   :text
#  log_time      :datetime
#  status        :integer
#  last_modified :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Log < ActiveRecord::Base
  attr_accessible :last_modified, :log_message, :log_time, :log_type, :server_id, :status
end
