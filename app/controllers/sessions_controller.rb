
class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email params[:user][:email].to_s
    if user
      if user.status == false
        redirect_to  new_user_session_path, :alert => "Your account is blocking" and return
      end
    end
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
end
