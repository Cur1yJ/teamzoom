# == Schema Information
#
# Table name: archives
#
#  id            :integer          not null, primary key
#  bucket_id     :integer
#  recording_id  :integer
#  file_name     :string(255)
#  file_format   :string(255)
#  file_date     :datetime
#  status        :integer
#  last_modified :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Archive do
  pending "add some examples to (or delete) #{__FILE__}"
end
