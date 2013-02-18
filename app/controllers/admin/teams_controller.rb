
class Admin::TeamsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  #-----------------------------------FILTER-----------------------------------
  # TODO
  #----------------------------------------------------------------------------
  #--------------------------------ACCOUNT SETTING---------------------------
  #   Description: 
  #             - every "people" can visit this page without login
  #             These action for manager only
  #               - show list of managers, school address, program details            
  #               - add new manager, change school address                   
  #     Parameters                                                         
  #       id      :  teampage_id
  #     Output    
  #       @school_adress : address of school   
  #       @team_managers : list of team administrators (managers)   
  #     
  #-------------------------------------------------------------------------
  def show
    @team = Team.find(params[:id].to_s)
    @team_managers = @team.managers if @team
    @school_address = @team.school.address if @team && @team.school
    render :layout => "team_layout"
  end
  
  def index
    @states = State.active.order("name ASC")
    @conferences = []
    #respond_to do |format|
    if params[:conference_id_admin].blank? and params[:school_admin].blank?
      @teams = Team.paginate(:page => params[:page] , :per_page => 15 ,:order => "name ASC")      
    elsif params[:school_admin].blank?
      @conference = Conference.find_by_id(params[:conference_id_admin].to_s)
      @teams = @conference.teams.paginate(:page => params[:page] , :per_page => 15 ,:order => "name ASC") if @conference
    else
      @teams = Team.where("lower(name) like '%#{params[:school_admin].downcase}%'").uniq.paginate(:page => params[:page] , :per_page => 15 ,:order => "name ASC")
    end
    render :layout => "admin"
      #format.html
     # format.js
    #end
  end
  def edit
    @states = State.active.order("name ASC").map {|s| [s.name,s.id]}
    @team = Team.find_by_slug(params[:id].to_s)
    @state = @team.school.conference.state 
    @conferences = @state.conferences.active.order("name ASC").map {|s| [s.name,s.id]}
    @conference = @team.school.conference 
  end

  def update
    @team = Team.find(params[:id].to_s)
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.js
      else
        format.js
      end
    end
  end
  def new
    @team = Team.new    
    @school = @team.build_school
    @conference = @school.build_conference
    @states = State.active.order("name ASC").map {|s| [s.name,s.id]}
    @conferences = []
     respond_to do |format|   
        format.js  
    end
   
  end

  def create
    @team = Team.new(params[:team])
     respond_to do |format|   
        format.js  
    end
    @team.save
  end
  
  def search    
    if params[:state_id].blank?
      @conferences =[]
      render :partial => "conferences/conference_admin"
    else
      @conferences = Conference.active.scoped_by_state_id(params[:state_id])
      render :partial => "conferences/conference_admin"
    end
  end
  
  def get_conferences    
    if params[:state_id].blank? 
      @conferences =[]
    else
      @conferences = Conference.active.scoped_by_state_id(params[:state_id])
    end
    render :json => @conferences.to_json
  end
end
