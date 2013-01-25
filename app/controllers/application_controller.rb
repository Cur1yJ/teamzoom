class ApplicationController < ActionController::Base
  protect_from_forgery
  # check_authorization :unless => :devise_controller?, :except => [:index]

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = exception.message
  	redirect_to root_url
  end
  
  
  def self.is_manager_or_admin(user,team)
    if user
      if ((user.role == User.manager_role && 
         user.teamsmanage.include?(team)) ||
         user.role == User.administrator_role)
         true
      end
    end
  end
  
  
  
end
