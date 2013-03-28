
class Admin::SchedulesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :team
  # Load data for select
  def load_subteams
    subteams = Team.find(params[:team].to_s).teamsports.where(:sport_id => params[:sport_id]).collect{|t_sport| t_sport.subteams}
    results = []
    subteams.each {|sub|
      unless sub.empty?
        results = sub
      end
    }
    render :json => results.to_json
  end

  def load_teams
    teams = Sport.find(params[:sport].to_s).teamsports.collect {|sport| sport.team}
    @teams = teams.uniq
    render :json => @teams.to_json
  end

  def load_venues
    team = Team.find_by_id(params[:team_id].to_s)
    venues = team.venues
    render :json => venues.to_json
  end

  # Load team for sport
  def load_teams_for_sport
    sport = Sport.find(params[:sport_id].to_s)
    teams = sport.teamsports.map {|sport| sport.team}
    subteams = Subteam.joins(:teamsport).order("name ASC").where("teamsport_id IN (?)", Teamsport.where(:sport_id => sport.id))
    render :json => [subteams, teams]
  end

  def new
    @schedule = Schedule.new
    @subteam_home = @schedule.build_subteam_home
    @team_home = @subteam_home.build_team
    @subteam_opponent = @schedule.build_subteam_opponent
    @team_opponent = @subteam_opponent.build_team_opponent
  end

  def create
    team_id = params[:schedule][:subteam_home][:team_id].to_i
    params[:schedule].delete :subteam_opponent
    params[:schedule].delete :subteam_home

    begin
      event_date_error = ""
      if params[:schedule][:event_date].present?
        event_date = DateTime.parse(params[:schedule][:event_date])
        params[:schedule]["start_time(1i)"] = params[:schedule]["end_time(1i)"] = event_date.year.to_s
        params[:schedule]["start_time(2i)"] = params[:schedule]["end_time(2i)"] = event_date.month.to_s
        params[:schedule]["start_time(3i)"] = params[:schedule]["end_time(3i)"] = event_date.day.to_s
      end
    rescue
      event_date_error = "wrong date format"
    end

    @schedule = Schedule.new(params[:schedule])
    respond_to do |format|
      if @schedule.save
        date = session[:date] || @schedule.event_date
        if date.class == Date
          date = Date.strptime(date.strftime("%m-%d-%Y"),"%m-%d-%Y")
        end
        sport_id = session[:sport]
        @schedules = Schedule.filter_schedule(@team.id, date, sport_id) || []
        Schedule.recording_name(@schedule.id)
        format.js
      else
        @schedule.errors[:event_date] = event_date_error if event_date_error.present?
        format.js
      end
    end
  end

  def edit
    @schedule = Schedule.find(params[:id].to_s)
  end

  def update
    @schedule = Schedule.find(params[:id])
    @order = current_user.orders.build if current_user
    team_id = params[:schedule][:subteam_home][:team_id].to_i
    params[:schedule].delete :subteam_opponent
    params[:schedule].delete :subteam_home
    sport_id = session[:sport] || @schedule.sport_id
    respond_to do |format|
      if params[:schedule][:event_date].present?
        event_date = DateTime.parse(params[:schedule][:event_date])
      else
        event_date = DateTime.now
      end
      params[:schedule]["start_time(1i)"] = params[:schedule]["end_time(1i)"] = event_date.year.to_s
      params[:schedule]["start_time(2i)"] = params[:schedule]["end_time(2i)"] = event_date.month.to_s
      params[:schedule]["start_time(3i)"] = params[:schedule]["end_time(3i)"] = event_date.day.to_s
      params[:schedule]["start_time(4i)"] ||= @schedule.start_time.hour.to_s
      params[:schedule]["start_time(5i)"] ||= @schedule.start_time.min.to_s

      if @schedule.update_attributes(params[:schedule])
        date = session[:date] || @schedule.event_date
        if date.class == Date
          date = Date.strptime(date.strftime("%m-%d-%Y"),"%m-%d-%Y")
        end
        sport_id = session[:sport]
        @schedules = Schedule.filter_schedule(@team.id, date, sport_id) || []
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    team_id = @schedule.subteam_home.teamsport.team.id
    date = session[:date] || @schedule.event_date
    if date.class == Date
      date = Date.strptime(date.strftime("%m-%d-%Y"),"%m-%d-%Y")
    end
    @schedule.destroy
    respond_to do |format|
      @schedules = Schedule.filter_schedule(@team.id, date) || []
      format.js
    end
  end
  def team
    @team = Team.find_by_slug(params[:team_id]) # will remove when have user's right
  end

  def load_sports_venues
    @team = Team.find_by_id(params[:team_id])
    @teamsport = @team.teamsports.build
    respond_to do |format|
      format.js
    end
  end
end
