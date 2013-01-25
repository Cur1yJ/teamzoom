# == Schema Information
#
# Table name: sports
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  imgage      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean
#

require 'spec_helper'

describe Sport do
  pending "add some examples to (or delete) #{__FILE__}"
end
