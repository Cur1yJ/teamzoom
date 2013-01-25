# == Schema Information
#
# Table name: schedules
#
#  id             :integer          not null, primary key
#  subteam_id     :integer
#  opponent_id    :integer
#  sport_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_time     :datetime
#  event_date     :datetime
#  score_home     :float
#  score_opponent :float
#  venue_id       :integer
#  end_time       :datetime
#  us_timezone   :string(255)
#

# require 'date'
class Schedule < ActiveRecord::Base
	# belongs_to :team
  belongs_to :subteam_home, :class_name => "Subteam", :foreign_key => "subteam_id"
  belongs_to :subteam_opponent, :class_name => "Subteam", :foreign_key => "opponent_id"
  attr_accessible :subteam_id, :sport_id , :venue_id,  :start_time, :end_time, :event_date , :opponent_id,
  :score_home, :score_opponent, :us_timezone
  belongs_to :sport
  belongs_to :venue
  has_one :recording
  validates_presence_of :sport_id , :venue_id,  :start_time , :event_date, :opponent_id, :subteam_id

  US_TIME_ZONES_HASH = {"(GMT-05:00) Eastern Time (US & Canada)" => "Eastern Time (US & Canada)",
                        "(GMT-06:00) Central Time (US & Canada)" => "Central Time (US & Canada)",
                        "(GMT-07:00) Mountain Time (US & Canada)" => "Mountain Time (US & Canada)",
                        "(GMT-08:00) Pacific Time (US & Canada)" => "Pacific Time (US & Canada)"
                      }
  US_TIME_ZONES = ["Eastern Time (US & Canada)", "Central Time (US & Canada)",
                  "Mountain Time (US & Canada)", "Pacific Time (US & Canada)"]

  validates :start_time, :uniqueness => true, :uniqueness => { :scope => [:venue_id, :event_date],
    :message => "should happen once per location" }
  validates :start_time, :uniqueness => { :scope => [:subteam_id, :event_date],
    :message => "should happen once per team home" }
  validates :start_time, :uniqueness => { :scope => [:opponent_id, :event_date],
    :message => "should happen once per team opponent" }
  validates_time :start_time, :before => :end_time
  validates :us_timezone, :inclusion => { :in => US_TIME_ZONES,
    :message => "%(value) is not in time zone list"}

  validate :subteam_home_and_subteam_away

  def subteam_home_and_subteam_away
    errors.add(:opponent_id, "can't be the same as subteam home") if opponent_id == subteam_id
    errors.add(:subteam_id, "can't be the same as subteam opponent") if opponent_id == subteam_id
    errors.add(:opponent_id, "can't be blank") if opponent_id == 0
    errors.add(:subteam_id, "can't be blank") if subteam_id == 0
    errors.add(:venue_id, "can't be blank") if venue_id == 0
  end

  def self.filter_schedule(team_id, start_date = nil, sport_id = nil)
    start_date = start_date.beginning_of_week unless start_date.nil?
    end_date = start_date.end_of_week unless start_date.nil?
    sl_schedule = "select * from schedules"
    sl_where_date = "where ( event_date between '#{start_date}' and '#{end_date}')"
    sl_subteam = "((subteam_id in
                     (select subteams.id from subteams, teamsports where
                     subteams.teamsport_id = teamsports.id and teamsports.team_id = #{team_id})
                  )
                  or
                  (opponent_id in
                     (select subteams.id from subteams, teamsports where
                     subteams.teamsport_id = teamsports.id and teamsports.team_id = #{team_id})
                  ))"
    sl_sport = "sport_id = #{sport_id}"
    sql = ""
    if start_date.nil? && (sport_id.nil? || sport_id.blank?)
      sql = [sl_schedule, sl_subteam].join(" where ")
    elsif start_date && (sport_id.nil? || sport_id.blank?)
      sql = [sl_schedule, sl_where_date].join(" ")
      sql = [sql,sl_subteam].join(" and ")
    elsif start_date.nil? && sport_id
      sql = [sl_schedule, sl_sport].join(" where ")
      sql = [sql, sl_subteam].join(" and ")
    elsif start_date && sport_id
      sql = [sl_schedule, sl_where_date].join(" ")
      sql = [sql, sl_sport].join(" and ")
      sql = [sql, sl_subteam].join(" and ")
    end
    sql += "ORDER BY event_date DESC"
    schedules = Schedule.find_by_sql(sql)
    return schedules
  end

  def start_time
    return self[:start_time] if self[:start_time].nil?
    case self.us_timezone
    when US_TIME_ZONES[0]
      self[:start_time]
    when US_TIME_ZONES[1]
      self[:start_time] - 1.hour
    when US_TIME_ZONES[2]
      self[:start_time] - 2.hour
    when US_TIME_ZONES[3]
      self[:start_time] - 3.hour
    end
  end

  def end_time
    return self[:end_time] if self[:end_time].nil?
    case self.us_timezone
    when US_TIME_ZONES[0]
      self[:end_time]
    when US_TIME_ZONES[1]
      self[:end_time] - 1.hour
    when US_TIME_ZONES[2]
      self[:end_time] - 2.hour
    when US_TIME_ZONES[3]
      self[:end_time] - 3.hour
    end
  end

  def start_time=(time)
    new_time_zone = self.us_timezone
    disparity_zone = US_TIME_ZONES.index(new_time_zone)
    self[:start_time] = time + disparity_zone.hours
  end

  def end_time=(time)
    new_time_zone = self.us_timezone
    disparity_zone = US_TIME_ZONES.index(new_time_zone)
    self[:end_time] = time + disparity_zone.hours
  end

  def time_zone_abbreviation
    case us_timezone
    when US_TIME_ZONES[0]
      "EST"
    when US_TIME_ZONES[1]
      "CST"
    when US_TIME_ZONES[2]
      "MST"
    when US_TIME_ZONES[3]
      "PST"
    end
  end

end

