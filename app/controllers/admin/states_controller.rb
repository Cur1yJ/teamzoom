
class Admin::StatesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js, :html
  layout "admin"
  def index
    @states = State.order("name desc").active
    #render :partial => "states", :locals => {:states => @states}
  end
  def new
    @state = State.new
  end
  
  def edit 
    @state = State.find(params[:id].to_s)
  end 
  
  def update 
    @state = State.find(params[:id].to_s)
    @state.update_attributes(params[:state])
  end 
  
  def create
    @state = State.find_by_name(params[:state][:name].to_s)
    if @state 
      @state.active = true 
    else
      @state = State.new(params[:state])
    end
    respond_to do |format|
      if @state.save
        format.js 
      else
        format.js
      end
    end
  end
  
  def change_status
    @state = State.find(params[:id].to_s)
    conferences = @state.conferences 
    other = State.find_or_create_by_name("Other")
    other.update_attribute(:active, true)
    conferences.each do |conf|
      conf.update_attributes(:state_id => other.id)
    end 
    @state.update_attribute(:active, false)
  end 
end
