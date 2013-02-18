
class TeamsController < ApplicationController
  #load_and_authorize_resource
   # before_filter :authenticate_user!, :except => [ :show, :index]
  # before_filter :authenticate_user!
  
  before_filter :apply_cancel , :only => [:show, :find_team]
  
  def show
    @team = Team.find_by_slug(params[:id].to_s)
    @teamsport = @team.teamsports.build
    @order = current_user.orders.build if current_user
    @date = session[:date] ? session[:date] : DateTime.now
    @date = @date.beginning_of_week
    session[:date] = @date
    session[:team_id] = @team.id
    @sport = Sport.active.order("name ASC")
    @schedule = Schedule.filter_schedule(@team.id, @date)
    render :layout => "team_layout"
  end

  def show_sport
    session[:sport] = params[:sport]
    team_id = params[:team_id]
    team = Team.find_by_id(team_id)
    @schedule = Schedule.filter_schedule(team_id, session[:date], session[:sport]) || []
    render :partial => "teams/schedule", :locals => {:schedule => @schedule, :team => team}
  end

  def find_or_initial_teamsport
    @team = Team.find(params[:team_id].to_s)
    @teamsport = @team.teamsports.find_or_initialize_by_sport_id(params[:teamsport_id])
    respond_to do |format|
      format.js
    end
  end

  def update_venue
    @team = Team.find(params[:id].to_s)
    if params[:teamsport][:id].present?
      @teamsport = Teamsport.find(params[:teamsport][:id])
      respond_to do |format|
        if @teamsport.update_attributes(params[:teamsport])
          format.html{redirect_to @team, notice: "subteam and venue is updated."}
          format.js
        else
          format.html{redirect_to @team, notice: "unable to update, subteam already exists."}
          format.js
        end
      end
    else
      @teamsport = @team.teamsports.find_or_initialize_by_sport_id(params[:teamsport][:sport_id])
      respond_to do |format|
        if @teamsport.update_attributes(params[:teamsport])
          format.html{redirect_to @team, notice: "subteam and venue is created."}
          format.js
        else
          format.html{redirect_to @team, notice: "unable to create"}
          format.js
        end
      end
    end
  end

  def change_date
    @date = params[:month] ? DateTime.civil(params[:year].to_i, params[:month].to_i, params[:date].to_i) : DateTime.now
    session[:date] = @date
    @team = Team.find_by_id(session[:team_id])
    @order = current_user.orders.build if current_user
    @schedules = Schedule.filter_schedule(session[:team_id], session[:date], session[:sport]) || []
  end

  #/teams/1/conference_directory
  def conference_directory
    @team = Team.find(params[:id].to_s)
    @conference = @team.school.conference
    @teams = @conference.teams.paginate(:page => params[:page] , :per_page => 15 ,:order => "name ASC")
    render :layout => "team_layout"
  end

  def new
    @team = Team.new
    @schools = School.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id].to_s)

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.js
        format.html { redirect_to @team, notice: 'Team is successfully updated.' }
        format.json { head :no_content }
      else
        format.js
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id].to_s)
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def find_team
    @states = State.active
    @conferences = []
    @schools = []
    @request = Request.new
  end

  def search
    @teams = Team.scoped_by_school_id(params[:school_id])
    render :partial => "teams/teams"
  end

  #Loading schedule data by sport type in the time
  def schedule_loading
    team_id = params[:team_id]
    team = Team.find_by_id(team_id)
    sport_id =  params[:sport_id]
    date_of_week = params[:date_of_week]
    date = Date.strptime(date_of_week,"%m-%d-%Y")
    @schedule = nil
    @schedule = Schedule.filter_schedule(team_id, date, sport_id)
    @date
    render :partial => "teams/schedule", :locals => {:schedule => @schedule, :team => team}
  end

  #Loading school data by school
  def get_team_by_scholl
    @school = nil
    @teams = nil
    if params[:school_id]
      @school = School.find_by_id(params[:school_id].to_s)
      if @school
        @teams = @school.teams
        return render :partial => "registrations/team_select", :locals => {:teams => @teams}
      else
        return render :partial => "registrations/team_select", :locals => {:teams => nil}
      end
    end

  end

private

  def apply_cancel
    if current_user
      Order.update_cancel_on_end_month(current_user)
    end
  end 
end

