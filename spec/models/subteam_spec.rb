# == Schema Information
#
# Table name: subteams
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  name         :string(255)
#  image        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  teamsport_id :integer
#

require 'spec_helper'

describe Subteam do
  pending "add some examples to (or delete) #{__FILE__}"
end
