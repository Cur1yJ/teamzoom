require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'

#ActiveMerchant::Billing::Base.mode = :production
ActiveMerchant::Billing::Base.mode = :test
# AUTHORIZE.NET
# https://test.authorize.net/:
# https://test.authorize.net/:
# Configure for test account
TEST_AN_CARD_NOT_PRESENT_LOGIN = "7sf85sNMT9w"
TEST_AN_CARD_NOT_PRESENT_TRANS_KEY = "6q254fpDRG8nX48d"
# Configure for real account
AN_CARD_NOT_PRESENT_LOGIN = "2R2EptZb9e"
AN_CARD_NOT_PRESENT_TRANS_KEY = "72M9Dd49Bnfz8hd8"

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

