class Admin::ConferencesController < ApplicationController
  
  load_and_authorize_resource 
  before_filter :authenticate_user!
  layout "admin"
  
  def index
    @conferences = Conference.order("updated_at DESC").active
  end

	def new
		@conference = Conference.new#(active: true)
		respond_to do |format|
			format.js
		end
	end

	def create
	  @conference = Conference.find_by_name(params[:conference][:name])
	  if @conference
	    @conference.active = true 
	  else 
  		@conference = Conference.new(params[:conference])
    end
		respond_to do |format|
			if @conference.save
				format.js
			else
				format.js
			end
		end
	end

	def edit
		@conference = Conference.find params[:id]
		respond_to do |format|
			format.js
		end
	end

  def update
    @conference = Conference.find params[:id]
    respond_to do |format|
      if @conference.update_attributes(params[:conference])
        format.js
      else
        format.js
      end
    end
  end

  def change_status 
    @conference = Conference.find(params[:id])
    schools = @conference.schools
    other_state = State.find_or_create_by_name("Other")
    other_conf = Conference.find_by_name("Other")
    unless other_conf 
      other_conf = Conference.create(:name => "Other", :state_id => other_state.id, :active => true)
    end 
    schools.each do |school|
      school.update_attribute(:conference_id, other_conf.id)
    end
    @conference.update_attribute(:active, false)
	end 
end


