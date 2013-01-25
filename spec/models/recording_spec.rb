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

require 'spec_helper'

describe Recording do
  pending "add some examples to (or delete) #{__FILE__}"
end
