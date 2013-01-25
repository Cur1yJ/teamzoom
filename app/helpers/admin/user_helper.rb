module Admin::UserHelper

	def active_edit_mode
		session[:edit_mode] = params[:edit_mode] || session[:edit_mode]
		current_user.edit_mode = session[:edit_mode] ? session[:edit_mode] : "asdf" if user_signed_in?
	end

	def user_admin?
		if user_signed_in?
			current_user.role == "Admin"
		else
			false
		end
	end

	def user_manager?
		if user_signed_in?
			if (params[:id] and params[:controller] == "teams") && params[:team_id].nil?
				if Team.find(params[:id]).user_ids.include?(current_user.id)
					current_user.is_manager?
				else
					false
				end
			elsif params[:team_id]
				if Team.find(params[:team_id]).user_ids.include?(current_user.id)
					current_user.is_manager?
				else
					false
				end
			end
		else
			false
		end
	end

	def user_admin_with_edit_mode?
		if user_admin?
			active_edit_mode == "active"
		else
			false
		end
	end

	def user_manager_with_edit_mode?
		if user_manager?
				active_edit_mode == "active"
		else
			false
		end
	end
end
