# == Schema Information
#
# Table name: s3_buckets
#
#  id            :integer          not null, primary key
#  s3_url        :string(255)
#  s3_zone       :string(255)
#  s3_permission :string(255)
#  status        :integer
#  last_modified :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe S3Bucket do
  pending "add some examples to (or delete) #{__FILE__}"
end
