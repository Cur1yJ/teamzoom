# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  ip_address      :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  card_type       :string(255)
#  card_expires_on :date
#  address1        :string(255)
#  address2        :string(255)
#  state           :string(255)
#  city            :string(255)
#  zip_code        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :boolean          default(FALSE)
#  total_price     :decimal(, )
#  individual_game :boolean          default(FALSE)
#  school_id       :integer
#  team_id         :integer
#  tax             :decimal(, )
#  subscription_id :string(255)
#

class Order < ActiveRecord::Base
  attr_accessor :card_number, :card_verification
  attr_accessible :card_expires_on, :user_id, :card_type, :first_name, :ip_address, :last_name,
  :address1, :address2, :state, :city, :zip_code, :card_number, :card_verification, :status,
  :total_price, :individual_game, :tax, :school_id, :team_id, :subscription_id, :cancel
  belongs_to :user
  has_many :transactions, :class_name => "OrderTransaction", :dependent => :destroy
  has_one :school
  has_one :team
  validates_format_of :zip_code, :with => /^\d*$/
  validate :validate_card, :on => :create
  validates_presence_of :address1, :city, :zip_code, :first_name, :last_name, :card_number, :card_verification, :card_expires_on
  validates_presence_of :card_type, :message => "Please choose card type!"

  CARD = [["Visa", "visa"], ["MasterCard", "master"], ["Discover", "discover"], ["American Express", "american_express"], ["Diners Club/ Carte Blanche", "dinners_club"], ["JCB", "jcb"]]
  PRICE_GAME = 5
  PRICE_MONTH = 30
  PERCENT_TAX = 0.0
  TYPES = {:visa => "visa", :master => "master",
           :am_express => "american_express", :discover => "discover"}


  def purchase_recurring
    response = GATEWAY.recurring(price_in_cents, credit_card, recurring_options)
    transactions.create!(:action => "recurring", :amount => total_price, :params => response)
    self.update_attributes(:status => response.success?, :subscription_id => response.params['subscription_id'])
    logger.info "===============RECURRING==============="
    logger.info [response].inspect
    logger.info response.success?
    response
  end

  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => total_price, :params => response)
    self.update_attribute :status, response.success?
    self.update_attribute :transaction_id, response.params['transaction_id']
    logger.info "===============PURCHASE==============="
    logger.info [response].inspect
    logger.info response.success?
    response
  end

  def cancel_recurring
    response = GATEWAY.cancel_recurring(self.subscription_id)
    if response.success?
      self.update_attribute(:cancel, true)
    end
  end

  def self.update_cancel_on_end_month(user)
    monthly_payment = user.orders.order("created_at ASC").where(:individual_game => false, :cancel => true).last
    today = Date.today
    if monthly_payment && today == monthly_payment.created_at.next_month.to_date && monthly_payment.cancel
      monthly_payment.update_attribute(:status, false)
    end
  end
  def price_in_cents
    total_price * 100
  end

  private
  def purchase_options
    {
      :ip => ip_address,
      :amount => price_in_cents,
      :subscription_name => "Test Subscription",
      :billing_address => {
        :address1 => address1,
        :address2 => address2,
        :city => city,
        :state => state,
        :country => "US",
        :zip => zip_code
      }
    }
  end

  def recurring_options
    {
      :ip => ip_address,
      :amount => price_in_cents,
      :subscription_name => "Test Subscription",
      :billing_address => {
        :address1 => address1,
        :address2 => address2,
        :city => city,
        :state => state,
        :country => "US",
        :zip => zip_code,
        :first_name => first_name,
        :last_name => last_name
      },
      :interval => {
                      :unit => :months,
                      :length => 1
                   },
      :duration => {
                      :start_date => Date.today,
                      :occurrences => 9999
                   }
    }
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.each  do |error, message|
        if error == "number"
          self.errors.add :card_number, message.to_sentence unless message.blank?
        end
        if error == "brand"
          self.errors.add(:card_number, "is not a valid credit card number") unless message.blank?
        end
        if error == "verification_value"
          self.errors.add :card_verification, message.to_sentence
        end
        if error == "year" || error == "month"
          self.errors.add :card_expires_on, message.to_sentence
        else
          self.errors.add :base, message.to_sentence
        end
      end
    end
  end

  def credit_card()
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new( {
      :number => card_number,
      :verification_value => card_verification,
      :type     => card_type,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name => last_name
      }
    )
    return @credit_card
  end

end

