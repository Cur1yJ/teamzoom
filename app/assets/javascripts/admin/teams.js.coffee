window.homeObject =
  setup: ->
    # @clickStateAdmin()
    # @clickOnSearchadmin()
    # @resetDefaultadmin()
    # @clickConferenceAdmin() 
    # @clickOnEdit()  
    return

$(".admin_search #update_team").live ("keyup"),(e)->
  label = $(this).val() + " " + $(".admin_search #update_mascot").val()
  $(".admin_search .team_name label").html(label)
  $(".admin_search #team_name").val(label)

$(".admin_search #update_mascot").live ("keyup"),(e)->
  label = $(".admin_search #update_team").val() + " " + $(this).val()
  $(".admin_search .team_name label").html(label)
  $(".admin_search #team_name ").val(label)

# new team zoom 

$(".admin_search #admin_new_team #team_school_attributes_name").live ("keyup"),(e)->
  if ($(".admin_search #admin_new_team #team_mascot").val()== "")
    label = $(this).val()
    $(".admin_search #admin_new_team #showteamname").html(label)
    $(".admin_search #admin_new_team .name_hidden").val(label)
  else
    label = $(this).val() + " " + $(".admin_search #team_mascot").val()
    $(".admin_search #admin_new_team #showteamname").html(label)
    $(".admin_search #admin_new_team .name_hidden").val(label)

$(".admin_search #admin_new_team #team_mascot").live ("keyup"),(e)->
  if($(".admin_search #admin_new_team #team_school_attributes_name").val =="")
    label = $(this).val()
    $(".admin_search #admin_new_team #showteamname").html(label)
    $(".admin_search #admin_new_team .name_hidden").val(label)
  else
    label = $(".admin_search #admin_new_team #team_school_attributes_name").val() + " " + $(this).val()
    $(".admin_search #admin_new_team #showteamname").html(label)
    $(".admin_search #admin_new_team .name_hidden").val(label)

#reset default new team

$(".admin_search #admin_new_team .clickonshow").live ("click"), (e) ->
  $("#new_team")[0].reset()
  $(".admin_search #admin_new_team #showteamname").html("")

# click state new team
$("#conference_state_id").live "change", (e)->
  conf_id = $("#team_school_attributes_conference_id")
  options = "<option value=''>Select one</option>"
  $("#team_school_attributes_conference_id option").remove()
  
  state = $(this).attr("value")
  if state == ""
    conf_id.append(options)
  else 
    $.ajax
      type: "GET"
      url: "teams/get_conferences"
      data: {state_id: state}
      success: (data)->
        i = 0
        while i < data.length
          options += "<option value=" + data[i]["id"] + ">" + data[i]["name"] + "</option>"
          i++
        conf_id.append(options)
        return
      error: (data)->
        alert("There are something went wrong")
  # clickOnEdit: ->
$("#admin_edit_team .team_id .link_edit").live 'click', (e) ->
  $.ajax
    type: "GET"
    url: $(this).data("url")       
    success:(data)->
      $("#edit_admin").html data
    error:(data)->

  # resetDefaultadmin: ->   
# if ($(".admin_search #selecter").val() is "")
#   $(".admin_search #state_id_admin option").first().attr("selected", "true")
#   $(".admin_search #conference_id_admin option").first().attr("selected", "true")


   # clickStateAdmin: ->
$(".admin_search #state_id_admin").change (e)-> 
  # $(".admin_search .state_admin").addClass "none"     
  $.ajax
    type: "GET"
    url: "teams/search"
    data: {state_id: $("#state_id_admin").attr("value")}
    success: (data)->
      $("#conference_admin").html data
      $("#conference_admin").show
    error: (data)->
      $("#conference_admin").html data
      $("#conference_admin").show
 
  ################################     
$(".admin_search .New_team").live ("click"), (e)->
  $(".admin_search .loading_admin").removeClass "none_admin"
  $(".admin_search .team_admin.none_admin").hide()
  form = $(".admin_search form")
  $.ajax
    type: "GET"
    url: form.attr("action")
    data: form.serialize()
    dataType: "script"
    success: (data)->
      $(".admin_search .loading_admin").addClass "none_admin"
    error: (data)->
      $(".admin_search .loading_admin").addClass "none_admin"
      $(".admin_search .team_admin").show()
  # click on update

# $("#edit_admin #admin_update_team").live ("click"), (e)->
#   $(".admin_search .loading_admin").removeClass "none_admin"
#   $(".admin_search .team_admin.none_admin").hide()
#   form = $(".admin_search form")
#   $.ajax
#     type: "GET"
#     url: form.attr("action")
#     data: form.serialize()
#     dataType: "script"
#     success: (data)->
#       $(".admin_search .loading_admin").addClass "none_admin"
#     error: (data)->
#       $(".admin_search .loading_admin").addClass "none_admin"
#       $(".admin_search .team_admin").show()


#---------------------------------------------------------
#     Call Ajax when click on delete_button
#     Remove the row has the id "team_manager#{count}"
#---------------------------------------------------------
$(".delete_button").click (e) ->
  r = confirm("Do you want to delete this manager")
  if r
    temp_string = $(this).attr("id")
    button_id   = temp_string.substring(6,temp_string.length)
    row_id      = "#team_manager"+button_id
    email_id    = "#manageremail"+button_id
    team_id   = $("#team#{button_id}").val();
    email_text = $(email_id).attr("placeholder");
    $(row_id).remove()
    $.ajax
      type: "get";
      url:  "/admin/users/delete_by_email" ;
      data: {email: email_text, team: team_id };
      success: (data)->
      error: (data)->

$(".change_button").click (e) ->
  r = confirm("Do you want to change this manager?")
  if r
    temp_string = $(this).attr("id")
    button_id   = temp_string.substring(6,temp_string.length)
    row_id      = "#team_manager"+button_id
    email_id    = "#manageremail"+button_id
    team_id   = $("#team#{button_id}").val()
    old_email_text = $(email_id).attr("placeholder")
    new_email_text = $(email_id).val()
    if new_email_text.match(/[\w|-|_|.|\d]+\@\w+\.\w+/)
      if new_email_text != old_email_text
        $.ajax
          type: "get",
          url:  "/admin/users/change_manager_by_email",
          dataType: "json",
          data: {old_email: old_email_text, new_email: new_email_text, team: team_id};
          success: (data)->
            if (data["result"])
              alert("Change manager successfully")
              $(email_id).attr("value", "")
              $(email_id).attr("placeholder", new_email_text)
            else
              alert("Unsuccessfully change the manager")
              $(email_id).attr("value", "")
          error: (data)->
            alert("error")

      else
        alert("Nothing change")
        $(email_id).attr("value", "")
    else
      alert("Invalid email input")
      $(email_id).attr("value", "")


