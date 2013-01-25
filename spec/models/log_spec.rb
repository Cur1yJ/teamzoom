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

require 'spec_helper'

describe Log do
  pending "add some examples to (or delete) #{__FILE__}"
end
