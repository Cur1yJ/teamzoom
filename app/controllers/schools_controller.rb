class SchoolsController < ApplicationController

  # search chools
  def search
    @schools = School.order("name ASC").scoped_by_conference_id(params[:conference_id])
    render :partial =>"shared/schools/school"
  end
  
  def get_school_by_conference
    @state        = nil
    @schools      = nil
    if params[:conference_id]
      @conference = Conference.find_by_id(params[:conference_id].to_i)
      if @conference
        @schools = @conference.schools.order("name ASC")
      end
    end
    render :partial => "registrations/school_select", :locals => { :schools => @schools}
	end

end
