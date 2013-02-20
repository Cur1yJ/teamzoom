class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:admin]
  # load_and_authorize_resource
  def index
  end
  
  def why_teamzoom
  end

  def about
  end

  def admin
    current_user.edit_mode = params[:edit_mode] ? params[:edit_mode] : "inactive"
    session[:edit_mode] = current_user.edit_mode
    # authorize! :admin, session[:edit_mode]
    respond_to do |format|
      format.html
    end
  end

  def conference
  end

  def find_team
  end

  def home_coache
            
  end

  def home_parent
  end

  def popup_demo
  end

  def pricing_signup
  end

  def team_page
  end
   
  def newrequest
    @home = RequestInstall.new
    respond_to do |format|
      format.html # new.html.erb
     # format.json { render json: @request }
      format.js
    end
  end
  
  def createrequest
    @home = RequestInstall.new(params[:home])
    respond_to do |format|
      if @home.save
         #UserMailer.request_installation(params[:email]).deliver  
         UserMailer.request_installation_to_admin(@home).deliver
         UserMailer.request_installation_to_user(@home).deliver
        format.html { redirect_to @home, notice: 'request was successfully created.' }
        #format.json { render json: @home, status: :created, location: @home }
        format.js
      else
         format.html { render action: "new" }
        #format.json { render json: @home.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  
end

