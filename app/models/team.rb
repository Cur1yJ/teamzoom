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

class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged]

  belongs_to :school
  # has_many :schedule
  has_many :teamsports
  has_many :sports, :through => :teamsports
  has_many :managers, :through => :team_managements, :source => :user
  has_many :users
  has_many :subteams, :dependent => :destroy
  has_many :venues, :dependent => :destroy
  attr_accessible :logo, :name, :subdomain, :logo_image, :subteams_attributes,
    :sports_attributes, :mascot, :school_attributes, :venues_attributes

  validates_associated :subteams, :venues

  accepts_nested_attributes_for :teamsports, :reject_if => lambda {|s| s[:name].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :subteams, :reject_if => lambda {|s| s[:name].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :sports, :reject_if => lambda {|s| s[:name].blank?}, :allow_destroy => true
  accepts_nested_attributes_for :venues, :reject_if => lambda {|s| s[:venue].blank?}, :allow_destroy => true

  accepts_nested_attributes_for :school

  has_many :team_managements

  has_many :users, :through => :team_managements
#  has_attached_file :logo_image,
#                    :styles => {:medium => "130x60>"},
#                    :url => "teams/:id/:style/:basename.:extension",
#                    :path => ":rails_root/public/assets/teams/:id/:style/:basename.:extension"

  #validates_attachment_size :logo_image, :less_than => 3.megabytes

#  has_attached_file :logo, :styles => { :small => "150x150>", :medium => "180x100>" },
#                  :url  => "/uploads/teams/logos/:id/:style/:basename.:extension",
#                  :path => ":rails_root/public/uploads/teams/logos/:id/:style/:basename.:extension"

  has_attached_file :logo, :styles => { :small => "150x150>", :medium => "180x100>" },
                   :storage => :s3,
                   :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
                   :default_url => 'common/logo_null.jpg',
                   :path => "logos/:id/:style.:extension"
  validates_attachment_size :logo, :less_than => 5.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  validates :mascot, :name, :presence => true
  validates :name, :uniqueness => :true


  def get_payment_for_team(from_date, end_date, individual_game = false)
    fees = 0
    data_count = 0
    results = {}
    begin
      team_id = self.id
      school_id = Team.find(team_id).school.id
      order_objs = Order.where("(team_id = ? or school_id = ?) and individual_game = ? and status IS TRUE", team_id, school_id , individual_game).where("created_at BETWEEN '#{from_date}' AND '#{end_date}'")
      data_count += order_objs.count
      order_objs.each {|order|
        fees += (order.total_price - order.tax)/2 #rescue 0
      } unless order_objs.empty?
    rescue
    end
      results = {:fees => fees, :data_count => data_count}
    return results
  end

  def get_payment_for_team_with_admin(from_date, end_date, individual_game = false)
    fees = 0
    results = {}
    data_count = 0
    begin
      team_id = self.id
      order_objs = Order.where("team_id IS NULL and school_id IS NULL and status IS TRUE and individual_game is #{individual_game}").where("created_at BETWEEN '#{from_date} ' AND '#{end_date}'")
      data_count += order_objs.count
      order_objs.each {|order|
        fees += (order.total_price - order.tax) #rescue 0
      } unless order_objs.empty?
#      data_subsribers = self.get_payment_for_team(from_date, end_date, false)
#      data_game = self.get_payment_for_team(from_date, end_date, individual_game)
#      data_count += (data_subsribers[:data_count])
#      fees  += (data_subsribers[:fees] + data_game[:fees])
       data = self.get_payment_for_team(from_date, end_date, individual_game)
       fees += data[:fees]
       data_count += data[:data_count]
    rescue
    end
    results = {:fees => fees, :data_count => data_count}
    return results
  end
end
