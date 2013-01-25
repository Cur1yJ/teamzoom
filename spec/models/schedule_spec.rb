# == Schema Information
#
# Table name: schedules
#
#  id             :integer          not null, primary key
#  subteam_id     :integer
#  opponent_id    :integer
#  sport_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_time     :datetime
#  event_date     :datetime
#  score_home     :float
#  score_opponent :float
#  venue_id       :integer
#  end_time       :datetime
#

require 'spec_helper'

describe Schedule do
  pending "add some examples to (or delete) #{__FILE__}"
end
