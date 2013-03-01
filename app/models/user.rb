# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string(255)
#  purchase_at            :date
#  team_id                :integer
#  status                 :boolean          default(TRUE)
#  user_type              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role,
                :individual_game, :user_type, :team_id

  after_save :add_default_role

  def add_default_role
    if role.nil?
      self.update_attribute(:role, "Customer")
    end
  end
  #---------------------------ADD MANAGE TEAM ID--------------------------------
  #    DESCRIPTION
  #               - nil if normaluser, team_id unless
  #               Normal user isnot belong to any team, except manager of team
  #-----------------------------------------------------------------------------
   has_many :team_managements
   has_many :teamsmanage, :through => :team_managements, :source => :team

   belongs_to :team
   accepts_nested_attributes_for :team
  #-----------------------------------------------------------------------------

  # attr_accessible :title, :body
  validates_confirmation_of :password

  ROLES = %W[Parent Fan Booster Coach Scout Other]
  STATUS = {true => "active", false => "Inactive"}

  CHANGE_STATUS = {"true" => false, "false" => true}
  PER_PAGE = 10
  attr_writer :current
  INCEPTION = 1
  THIS_YEAR = 2
  THIS_MONTH = 3
  PERIOD = 4
  LIMIT_PAYMENT_GAME = 4
  FITTER_DASH_BOARD = {INCEPTION => "Since Inception", THIS_YEAR => "This Year", THIS_MONTH => "This Month", PERIOD => "This Payment Period"}

  def name_from_email
    @name_from_email ||= email.split('@').first.gsub('.', ' ').gsub('_', ' ').split(' ').map {|s| s.capitalize}.join(' ')
  end

  def current
  	@current || step.first
  end

  def step
  	%w[user_register term_condition billing_details]
  end

  def next_step
  	self.current = step[step.index(current) + 1]
  end

  def is_payment
    check_expired_individual_game
    check_expired_cancel_recurring
    order = orders.where("id IS NOT NULL").last
    if order.nil? || !order.status
      return false
    else
      return true
    end
  end

  def check_subscriber
    subscribers = orders.where(:individual_game => false)
    if subscribers.last
      return subscribers.last.status
    else
      return false
    end
  end

  def check_expired_individual_game
    order = orders.where("id IS NOT NULL").last
    if !order.nil? && ((order.created_at.strftime("%Y-%m-%d %H:%M") <= DateTime.now.utc.ago(LIMIT_PAYMENT_GAME*3600).strftime("%Y-%m-%d %H:%M")) && order.status && order.individual_game)
      orders.last.update_attribute(:status, false)
    end
  end

  def check_expired_cancel_recurring
    order = orders.where("id IS NOT NULL").last
    if !order.nil? && ((order.created_at.strftime("%Y-%m-%d %H:%M") <= 1.month.ago.to_datetime.utc.strftime("%Y-%m-%d %H:%M")) && order.status && order.individual_game == false && order.cancel == true)
      orders.last.update_attribute(:status, false)
    end
  end

  attr_accessor :edit_mode
  # Get data for this year
  def get_subscriber_for_this_year(team_id, individual_game = false)
    this_year = Time.now.year
    data = []
    sum = 0
    fees = 0
    team = Team.find(team_id)
    (1..12).to_a.each do |mon|
       month = Date.new(this_year, mon)
       begin_month = month.beginning_of_month
       end_month = month.end_of_month
       # Same view payment for manager and admin
       if self.is_manager? || self.is_admin?
         rs = team.get_payment_for_team(begin_month, end_month, individual_game)
         order_count = rs[:data_count]
         fees += rs[:fees]
       end
       #order_count = self.class.count_times_of_payment(team_id, self, individual_game, begin_month, end_month)
       data << [mon.to_s, order_count]
       sum += order_count
    end
    return {:table_data => data, :count => sum, :fees => fees}
  end
  # Get data for this month
  def get_subscriber_for_this_month(team_id, individual_game = false)
    this_year = Time.now.year
    this_month = Time.now.month
    month = Date.new(this_year, this_month)
    begin_month = month.beginning_of_month
    end_month = month.end_of_month
    data = []
    sum = 0
    fees = 0
    team = Team.find(team_id)
    (1..6).to_a.each do |day|
      from_day = begin_month + 5*(day-1)
      if day != 6
        to_day = begin_month + 5*day
      else
        to_day = end_month
      end
      #order_count = self.class.count_times_of_payment(team_id, self, individual_game, begin_month, to_day)
      if self.is_manager? || self.is_admin?
        rs = team.get_payment_for_team(from_day, to_day, individual_game)
        order_count = rs[:data_count]
        fees += rs[:fees]
      end
      sum += order_count
      data << [(to_day).to_s, order_count]
    end
    return {:table_data => data, :count => sum, :fees => fees}
  end

  # Get data for this distance time
  def load_data_for_distance_time(team_id, begin_time, end_time, individual_game = false)
    sum = 0
    data = []
    fees = 0

    team = Team.find(team_id)
    begin_time = begin_time.split("-")
    end_time = end_time.split("-")
    from_date = Date.new(begin_time[2].to_i, begin_time[1].to_i, begin_time[0].to_i)
    to_date = Date.new(end_time[2].to_i, end_time[1].to_i, end_time[0].to_i)
    #order_count = self.class.count_times_of_payment(team_id, self, individual_game, from_date, from_date)
    if self.is_manager? || self.is_admin?
      rs = team.get_payment_for_team(from_date, from_date, individual_game)
      order_count = rs[:data_count]
      fees += rs[:fees]
    end
    sum += order_count
    data << [(from_date).to_s, order_count]
    #order_count = self.class.count_times_of_payment(team_id, self, individual_game, from_date, to_date)
    if self.is_manager? || self.is_admin?
      rs = team.get_payment_for_team(from_date, to_date, individual_game)
      order_count = rs[:data_count]
      fees += rs[:fees]
    end
    sum += order_count
    data << [(to_date).to_s, order_count]
    return {:table_data => data, :count => sum, :fees => fees}
  end

  def self.count_times_of_payment(team_id, current_user, individual_game, from_time, to_time)
    order_count = 0
    begin
      if individual_game
        users = self.where(:team_id => team_id)
        users.each do |user|
          order_count += user.orders.where(:individual_game => individual_game, :created_at => (from_time..to_time)).count
        end unless current_user.team.nil?
      else
        users = self.all
        users.each do |user|
          order_count += user.orders.where(:individual_game => individual_game, :created_at => (from_time..to_time)).count
        end
      end
    rescue
    end
    order_count
  end

  def self.search(email, page)
    self.where("lower(email) like ?", "%#{email.downcase}%").paginate(:page => page, :per_page => User::PER_PAGE)
  end

  def raised_funds
    funds = 0
    self.orders.map {|payment|
      funds += payment.total_price unless payment.total_price.nil?
    }
    return funds.round
  end
  #----------------------------------------------------------------------------
  #   DESCRIPTION:                                                            |
  #            manager_role and administrator_role return a string            |
  #----------------------------------------------------------------------------
  def self.manager_role
    "Manager"
  end

  def self.administrator_role
    "Admin"
  end
  def is_admin?
    role == "Admin"
  end
  def is_manager?
    role == "Manager" || !self.team_managements.empty?
  end
  
  after_update :update_info


  def update_info 
    #UserMailer.update_info(self).deliver
  end
  
end

