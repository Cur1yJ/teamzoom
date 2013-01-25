$ ->
  $(".status_true, .status_false").each ->
    $(this).click ->
      cl = $(this).attr("class")
      $(".ajax-loading").removeClass "hidden"
      active = cl.split("_")[1]
      obj = $(this)
      $.ajax
        type: 'PUT'
        url: '/admin/users/change_status'
        data:
          status: active, id: $(this).attr("value")
        success: (data) ->
          obj.html(data["value"])
          obj.removeClass(cl).addClass(cl.split("_")[0]+"_"+data["status"])
          $(".ajax-loading").addClass "hidden"
          return
        failure: ->
          alert("Something went wrong!")
          return
        complete: (data)->
    return
  if $("#not_school_list").is(":checked")
    $('.user_edit_team_sport #school-regist-box select').attr("disabled", "true")
    $('.user_edit_team_sport #conferences-regist-box select').attr("disabled", "true")
    $('.user_edit_team_sport #state-regist-box select').attr("disabled", "true")

  else
    $('.user_edit_team_sport #school-regist-box select').removeAttr("disabled")
    $('.user_edit_team_sport #conferences-regist-box select').removeAttr("disabled")
    $('.user_edit_team_sport #state-regist-box select').removeAttr("disabled")

  edit_user_team_val = $("#user_team_id").val()
  edit_user_team_txt = $("#team-regist-box").text()
  if $("#not_school_list").is(":checked")
    $('#school-regist-box select').attr("disabled", "true")
    $('#conferences-regist-box select').attr("disabled", "true")
    $('#state-regist-box select').attr("disabled", "true")

  else
    $('#school-regist-box select').removeAttr("disabled")
    $('#conferences-regist-box select').removeAttr("disabled")
    $('#state-regist-box select').removeAttr("disabled")

  $("#not_school_list").click ->
    if $(@).is(":checked")
      $("#school_id_regist").attr("disabled", "true").val("")
      $("#edit_user #school_id_regist").html("<option val = ''>Choose School</option>").attr("disabled", "true")
      $("#conference_id_regist").attr("disabled", "true").val("")
      $("#edit_user #conference_id_regist").html("<option val = ''>Choose Conference</option>").attr("disabled", "true")
      $("#state_id_regist").attr("disabled", "true").val("")
      $("#user_team_id").val("")
      $("#team-regist-box #team_name").text("")
    else
      $("#school_id_regist").removeAttr("disabled")
      $("#conference_id_regist").removeAttr("disabled")
      $("#state_id_regist").removeAttr("disabled")
      $("#user_team_id").val(edit_user_team_val)
      $("#team-regist-box #team_name").text(edit_user_team_txt)

  $(".update_user").live "click", ->
    conference =  $('.user_edit_team_sport #conferences-regist-box select option:selected').val()
    school = $('.user_edit_team_sport #school-regist-box select option:selected').val()

    comb_c_s = conference is '' or school is '' or school is 'Choose School'
    entire_com = isNaN(conference or school) or comb_c_s

    if ($('.user_edit_team_sport #state-regist-box select option:selected').val() is '' or entire_com) and not $("#not_school_list").is(':checked')
      $("#reference_error").removeClass("hidden")
      $(".alert").remove()
      $("<div class = 'alert alert-error'>Please choose States, conference, and school before update.</div>").insertBefore("#edit_user")
    else
      $.ajax
        url: $("#edit_user").attr("action")+".js"
        type: $("#edit_user").attr("method")
        data: $("#edit_user").serializeArray()
        async: false
  return