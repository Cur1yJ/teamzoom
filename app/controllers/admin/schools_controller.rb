######################################################################
# Change History
######################################################################
# Date-02/08/2013
# Coder- Michael Lungo 
# Description: SQL Injection-changed find(params[:id]) to  find(params[:id].to_s)              
######################################################################

class Admin::SchoolsController < ApplicationController
  #-----------------------------------FILTER-----------------------------------
  # TODO
  #----------------------------------------------------------------------------
  before_filter :authenticate_user!
  before_filter :get_team
  before_filter :can_task?
  
  def update_address
    puts "---------------------------------------------------------------------"
    puts params.inspect
    #--------------------------UPDATE SCHOOL ADDRESS---------------------------
    #     DESCRIPTION
    #                 Change address of school
    #                     - ADDRESS 1
    #                     - CITY
    #                     - STATE
    #--------------------------------------------------------------------------
    flash[:notice]= fail_message
    school=@team.school if @team
    school_address = params[:z]+"\@/"+params[:a] +"\@/"+ params[:c]+"\@/"+params[:s][:state]
    flash[:notice] = "Update school address unsuccessfully"
    if checkblank?
      puts "pass check blank"
      if school
        puts "school exist"
        if school.update_attributes(:address =>school_address)
          flash[:notice] = "Update school address successfully"
        end
      end
    end
    redirect_to admin_team_path(@team)
  end
  private

    def fail_message
      "Update school address unsuccessfully!"
    end

    def error_message
      "You can't access this function"
    end

    def get_team
      @team  = Team.find(params[:team_id].to_s)
    end

    def checkblank?
      if !(params[:z].blank? || params[:a].blank? || params[:c].blank? || params[:s].blank?)
        true
      end
    end
    
    def can_task?
      if !ApplicationController.is_manager_or_admin(current_user,@team)
        flash[:error] = error_message 
        redirect_to admin_team_path(@team)
      end
    end
end
