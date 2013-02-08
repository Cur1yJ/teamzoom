######################################################################
# Change History
######################################################################
# Date-02/08/2013
# Coder- Michael Lungo 
# Description: SQL Injection-changed find(params[:id]) to  find(params[:id].to_s)              
######################################################################

class SchedulesController < ApplicationController
  
  def show
    @schedule = Schedule.find(params[:id].to_s)
    
    respond_to do |format|
      format.json { render json: @schedule }
      format.js
    end
  end
end
