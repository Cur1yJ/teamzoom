# == Schema Information
#
# Table name: teamsports
#
#  id                      :integer          not null, primary key
#  sport_id                :integer
#  team_id                 :integer
#  name                    :string(255)
#  logo_image_file_name    :string(255)
#  logo_image_content_type :string(255)
#  logo_image_file_size    :integer
#  logo_image_updated_at   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'spec_helper'

describe Teamsport do
  pending "add some examples to (or delete) #{__FILE__}"
end
