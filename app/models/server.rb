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

class Server < ActiveRecord::Base
  attr_accessible :last_modified, :server_uri, :server_zone, :status
end
