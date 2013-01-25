# == Schema Information
#
# Table name: stats
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  stat_time   :datetime
#  stat_type   :integer
#  stat_count  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Stat < ActiveRecord::Base
  attr_accessible :schedule_id, :stat_count, :stat_time, :stat_type
end
