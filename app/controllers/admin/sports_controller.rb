
class Admin::SportsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  
  def index
    @sports = Sport.order("name desc").active
  end

  def show
    @sport = Sport.find(params[:id].to_s)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sport }
    end
  end

  def new
    @sport = Sport.new(:active => true)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sport }
      format.js
    end
  end

  def edit
    @sport = Sport.find(params[:id].to_s)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @sport = Sport.find_by_name(params[:sport][:name].to_s)
	  if @sport
	    @sport.active = true 
	  else 
  		@sport = Sport.new(params[:sport])
    end

    respond_to do |format|
      if @sport.save
        format.html { redirect_to @sport, notice: 'Sport was successfully created.' }
        format.json { render json: @sport, status: :created, location: @sport }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @sport.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @sport = Sport.find(params[:id].to_s)

    respond_to do |format|
      if @sport.update_attributes(params[:sport])
        format.html { redirect_to @sport, notice: 'Sport was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @sport.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def change_status 
    @sport = Sport.find(params[:id].to_s)
    @sport.update_attribute(:active, false)
  end
end
