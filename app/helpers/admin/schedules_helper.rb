module Admin::SchedulesHelper
  def get_subteam_home(schedule)
    sub_teams = schedule.sport.teamsports.where(:team_id => schedule.subteam_home.teamsport.team.id).map{|h| h.subteams}[0] || []
    sub_teams = sub_teams.order("name ASC")
  end
  def get_subteam_away(schedule)
    sub_opponent_teams = schedule.sport.teamsports.where(:team_id => schedule.subteam_opponent.teamsport.team.id).map{|o| o.subteams}[0] || []
    sub_opponent_teams = sub_opponent_teams.order("name ASC")
  end

  def is_venue_using_in_game(schedules)
    schedules.each do |s|
      return true if s.event_date.to_date == Date.today_in_zone(s.us_timezone) && time_without_zone(Time.now, s.us_timezone) >= s.start_time && time_without_zone(Time.now, s.us_timezone) <= s.end_time
    end
    false
  end

  def time_without_zone(time, zone = Schedule::US_TIME_ZONES[0])
    s = time.in_time_zone(zone).to_s
    Time.zone.parse s[0, s.rindex("-")]
  end
end
