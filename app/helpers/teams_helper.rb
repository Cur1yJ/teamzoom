module TeamsHelper
  def get_logo_team(team)
    # Team.find(team).logo_image.url(:medium)
    if team.logo_file_name
      team.logo.url
    else
      "common/logo_null.jpg"
    end
  end

  def dynamic_logo
		team_actions = %w[show edit conference_directory subscribers game_purchases viewers cancellations show]
		controllers = %w[teams admin/transactions admin/teams]
		if(controllers.include?(params[:controller]) and team_actions.include?(params[:action]))
			content_tag(:div,:class => "ok") do
				link_to(image_tag( get_logo_team(@team) , :class => "logo") , find_team_teams_url)+
				(link_to("Edit", "#logo_change", :class => "edit-block btn btn-primary btn-mini", "data-toggle" => "modal") if(user_admin_with_edit_mode? or user_manager_with_edit_mode?))+
				('<span>Powered By:</span>'.html_safe)+link_to(image_tag("common/teamzoom.png" , :class => "power") , root_url)
			end
		else
			link_to(image_tag('common/teamzoom_logo_final.png' , :class => "logo"), root_url)
		end
	end

end
