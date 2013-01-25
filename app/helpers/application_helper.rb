module ApplicationHelper

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def states
    [["Alaska", "AK"], ["Alabama", "AL"], ["Arkansas", "AR"], ["Arizona", "AZ"],
                     ["California", "CA"], ["Colorado", "CO"], ["Connecticut", "CT"], ["District of Columbia", "DC"],
                     ["Delaware", "DE"], ["Florida", "FL"], ["Georgia", "GA"], ["Hawaii", "HI"], ["Iowa", "IA"],
                     ["Idaho", "ID"], ["Illinois", "IL"], ["Indiana", "IN"], ["Kansas", "KS"], ["Kentucky", "KY"],
                     ["Louisiana", "LA"], ["Massachusetts", "MA"], ["Maryland", "MD"], ["Maine", "ME"], ["Michigan", "MI"],
                     ["Minnesota", "MN"], ["Missouri", "MO"], ["Mississippi", "MS"], ["Montana", "MT"], ["North Carolina", "NC"],
                     ["North Dakota", "ND"], ["Nebraska", "NE"], ["New Hampshire", "NH"], ["New Jersey", "NJ"],
                     ["New Mexico", "NM"], ["Nevada", "NV"], ["New York", "NY"], ["Ohio", "OH"], ["Oklahoma", "OK"],
                     ["Oregon", "OR"], ["Pennsylvania", "PA"], ["Rhode Island", "RI"], ["South Carolina", "SC"], ["South Dakota", "SD"],
                     ["Tennessee", "TN"], ["Texas", "TX"], ["Utah", "UT"], ["Virginia", "VA"], ["Vermont", "VT"],
                     ["Washington", "WA"], ["Wisconsin", "WI"], ["West Virginia", "WV"], ["Wyoming", "WY"]]

  end

  def role(user)
    role_name = "Customer"
    if !user.team_managements.empty?
      role_name = "Manager"
    elsif user.is_admin?
      role_name = "Admin"
    end
    return role_name
  end

  def popup_check_account(title,s)
    if !current_user
      link_to title, "#check_login", "data-toggle" => "modal"
    elsif !current_user.is_payment
      link_to title, "#check_login", "data-toggle" => "modal", :id => "payment", :value => s.id
    else current_user.is_payment
      link_to title, "#video_team", "data-toggle" => "modal"
    end
  end

  def title_check_account
    unless current_user
      "Login Request"
    else !current_user.is_payment
      "Payment Request"
    end
  end


  #----------------------------------------------------------------------------
  #   DESCRIPTION:
  #     Check if user can manage this teampage
  #     Return true if user can manage teampage, otherwise nil
  #----------------------------------------------------------------------------

  def can_manage_teampage?
    if user_signed_in?
      if (current_user.role == User.manager_role &&
         current_user.teamsmanage.include?(Team.find(params[:id]))) ||
         current_user.role == User.administrator_role
         true
      end
    end
  end
  def is_admin?
    if user_signed_in?
      if current_user.role == User.administrator_role
        true
      end
    end
  end
  def is_manager?
    if user_signed_in?
      if current_user.role == User.manager_role
        true
      end
    end
  end
end

