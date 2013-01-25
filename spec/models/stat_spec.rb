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

require 'spec_helper'

describe Stat do
  pending "add some examples to (or delete) #{__FILE__}"
end
