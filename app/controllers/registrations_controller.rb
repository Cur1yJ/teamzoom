class RegistrationsController < Devise::RegistrationsController
  def new
  	resource = build_resource({})
  	session[:order_step] ||= {}

    session[:order_step] = resource.current

    @team = resource.build_team
    @school = @team.build_school
    @conference = @school.build_conference
    @state = @conference.build_state

    respond_with resource
  end

  def create
    resource = build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        #UserMailer.welcome_email(resource).deliver
        respond_with resource, :location => after_sign_up_path_for(resource)
        flash[:notice] = "Sign up successfully"
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_sign_up_path_for(resource)
    new_order_path+"?option=true"
  end

end

