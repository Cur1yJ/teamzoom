# == Schema Information
#
# Table name: servers
#
#  id            :integer          not null, primary key
#  server_uri    :string(255)
#  server_zone   :string(255)
#  status        :integer
#  last_modified :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Server do
  pending "add some examples to (or delete) #{__FILE__}"
end
