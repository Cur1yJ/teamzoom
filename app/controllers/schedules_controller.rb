
class SchedulesController < ApplicationController
  
  def show
    @schedule = Schedule.find(params[:id].to_s)
    
    respond_to do |format|
      format.json { render json: @schedule }
      format.js
    end
  end
end
