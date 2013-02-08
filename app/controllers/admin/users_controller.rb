######################################################################
# Change History
######################################################################
# Date-02/08/2013
# Coder- Michael Lungo 
# Description: SQL Injection-changed find(params[:id]) to  find(params[:id].to_s)              
######################################################################

class Admin::UsersController < ApplicationController
  respond_to :js, :html, :json
  #-----------------------------------FILTER-----------------------------------
  # TODO
  #----------------------------------------------------------------------------
  before_filter :authenticate_user!
  before_filter :get_team,:except => [:delete_by_email,:change_manager_by_email, :search, :change_status, :index]
  before_filter :can_task?,:except => [:delete_by_email,:change_manager_by_email]
  
  def index
    page = params[:page] || 1
    if params[:email]
      @users = User.search params[:email], page.to_i
    else
      @users = User.order("email ASC").paginate(:page => page, :per_page => User::PER_PAGE)
    end
    render :layout => "admin"
  end
  #----------------------------------------------------------------------------
  #    ADD NEW USER (EXIST OR NOT) TO BE A TEAM MANAGER
  #    If exist user =>   update action
  #    If new user   =>   create action
  #    Add checking method for every action!
  #----------------------------------------------------------------------------

  def create
    flash[:notice]=fail_message
    if valid_user?
      @user = User.new(:email=>params[:user][:email],:password=>params[:user][:password])
      if @user.save
        if TeamManagement.new(:user_id =>@user.id,:team_id =>@team.id).save
          flash[:notice] = success_message
        end
      end
    end
    redirect_to admin_team_path(@team) 
  end
  #--------------------------------------------------------------------------
  #     DESCRIPTION
  #                 - Set Role user to Manager
  #                 - Add Team Manage id to user
  #--------------------------------------------------------------------------

  def update_by_email
    user = User.find_by_email(params[:email].to_s)
    flash[:notice] = fail_message
    if user
      if !user.teamsmanage.include?(Team.find(params[:team_id].to_s)) && user.role != User.administrator_role
        #if user.update_attributes(:role => User.manager_role)
        if TeamManagement.new(:user_id =>user.id, :team_id =>@team.id).save
          flash[:notice] = success_message
        end
        #end
      end
    end
    redirect_to admin_team_path(@team)
  end
  #---------------------ADMIN TASK---------------------------------------------
  # DESCRIPTION
  #          - delete a manager from teammangement
  #          - not update role to normal user evenif this user dont manage any team
  #          - Add filter TODO
  #----------------------------------------------------------------------------
  def delete_by_email
    puts params["email"], params["team"]
    manager = User.find_by_email(params["email"].to_s)
    manager.team_managements.find_by_team_id(params["team"].to_s).destroy()
  end
  #----------------------------------------------------------------------------
  def change_manager_by_email
    new_manager = User.find_by_email(params["new_email"].to_s)
    team = Team.find(params["team"].to_s)
    if new_manager
      if not_admin?(new_manager) && !team.managers.include?(new_manager)
          if User.find_by_email(params["old_email"].to_s).team_managements.find_by_team_id(params["team"].to_s).destroy() &&
            TeamManagement.create(:user_id => new_manager.id, :team_id => team.id)
            render :json => {:result => true}
          return
        end
      end
    end
    render :json => {:result => false}
  end

  def change_status
    begin
      user = User.find(params[:id].to_s)
      user.update_attribute(:status, User::CHANGE_STATUS[params[:status]])
      @status = User::STATUS[user.status]
      render :json => {:status => user.status, :value => @status}
    rescue
    end 
  end 
  private
  def get_team
    @team = Team.find(params[:team_id].to_s)
  end
  def success_message 
    "Add new Manager successfully"
  end
  def fail_message    
    "Error when add new Team Manager"
  end
  def error_message
    "You don't have enough permission"
  end
  def blank_user?
    params[:user][:email].blank? || params[:user][:password].blank?
  end
  def valid_user?
    if !User.find_by_email(params[:user][:email].to_s) && 
        params[:user][:password] == params[:user][:password_confirm] && !blank_user?
      puts"valid user"
      true
    end
  end
  def not_admin?(new_manager)
    new_manager.role != User.administrator_role
  end
  def can_task?
    if !ApplicationController.is_manager_or_admin(current_user,@team)
      flash[:error] = error_message 
      redirect_to admin_team_path(@team)
    end
  end
end
