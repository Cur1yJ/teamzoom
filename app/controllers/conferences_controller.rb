class ConferencesController < ApplicationController

  ######################################################################
  # Change History
  ######################################################################
  # Date-02/04/2013
  # Coder- Shrikant Khandare
  # Description:  Moved partial "conference" from view folder To 
  #               "shared/conferences/conference"
  #               Changed render path to "shared/conferences/conference"   
  ######################################################################  
  


  # Search conference
  def search
    if params[:state_id].blank?
      @conferences =[]
      @schools = []
    else
      @conferences = Conference.active.scoped_by_state_id(params[:state_id])
      @schools = []
    end
    render :partial => "shared/conferences/conference"
  end


  def get_conference_by_state
    @state = nil
    @conferences = nil
    if params[:state_id]
      @state = State.find_by_id(params[:state_id].to_i)
      if @state
        @conferences = @state.conferences.active
      end
    end
    render :partial => "registrations/conference_select", :locals => {:conferences => @conferences}
  end
  
end


