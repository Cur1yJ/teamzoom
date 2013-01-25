# == Schema Information
#
# Table name: teams
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  subdomain               :string(255)
#  school_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  slug                    :string(255)
#  logo_file_name          :string(255)
#  logo_content_type       :string(255)
#  logo_file_size          :integer
#  logo_updated_at         :datetime
#  logo_image_file_name    :string(255)
#  logo_image_content_type :string(255)
#  logo_image_file_size    :integer
#  logo_image_updated_at   :datetime
#  mascot                  :string(255)
#

require 'spec_helper'

describe Team do
  pending "add some examples to (or delete) #{__FILE__}"
end
