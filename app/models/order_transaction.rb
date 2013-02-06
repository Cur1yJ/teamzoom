

# == Schema Information
#
# Table name: order_transactions
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  action        :string(255)
#  amount        :decimal(, )
#  success       :boolean
#  authorization :string(255)
#  message       :string(255)
#  params        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OrderTransaction < ActiveRecord::Base

  belongs_to :order
  
  attr_accessible :action, :amount, :authorization, :message, :order_id, :params, :success
 
  serialize :params

  def response= (response)
    begin
      self.success = response.success?
      self.authorization = response.authorization
      self.message = response.message
      self.params = response.params
    rescue ActiveMerchant::ActiveMerchantError => e
      self.success = false
      self.authorization = nil
      self.message = e.message
      self.params = {}
    end
  end
  
end

