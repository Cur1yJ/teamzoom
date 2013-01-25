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
  
  def request_installation
    UserMailer.request_installation(params[:email]).deliver
    respond_to do |format|
      format.js
    end
  end
end
