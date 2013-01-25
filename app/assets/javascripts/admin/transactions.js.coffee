window.transactionObject =
  setup:->
    @filterOption()
    @checkTeamidRegister()

  filterOption: ->
    $("#filter").change ->
      $.ajax
        type: "GET"
        url: "/load_data_for_select"
        data: {time_select: $("#filter").attr("value"), individual: false}
        success: (data)->
          $("#total_raise").html(data)
          return
        error: (errors, status)->
          return
    $("#viewers_date_filter").change ->
      team_id = $("#team_id").val()
      $.ajax
        type: "GET"
        url: "/admin/teams/"+team_id+"/load_total_raise_by_time"
        data: {time_select: $("#viewers_date_filter").attr("value")}
        success: (data)->
          $("#total_raise").html(data)
          return
        error: (errors, status)->
          return
    $("#filters").change ->
      team_id = $("#team_id").val()
      $.ajax
        type: "GET"
        url: "/admin/teams/"+team_id+"/load_total_raise_by_time"
        data: {time_select: $("#filters").attr("value"), individual: $("#individual").val()}
        success: (data)->
          $("#total_raise").html(data)
          return
        error: (errors, status)->
          return
    $("#viewers_filter").change ->
      alert("test")
      $.ajax
        success: (data)=>
          $("#chart").html(data)
          return
        error: (error, status)->
          return


  checkTeamidRegister: ->
    $('.btn-register').live "click", ->
      # validation register input
      email   = $("#user_email").val()
      pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i)
      pass1   = $("#user_password").val()
      pass2   = $("#user_password_confirmation").val()
      role    = $("#user_role").val()
      error   = ""

      if pattern.test email
        $("#user_email").removeClass "require"
      else
        $("#user_email").addClass "require"
        error = "error"

      if pass1 == "" || pass1 != pass2
        $("#user_password").addClass "require"
        $("#user_password_confirmation").addClass "require"
        error = "error"

      else
        $("#user_password").removeClass "require"
        $("#user_password_confirmation").removeClass "require"

      if role == ""
        $("#user_role").addClass "require"
        error = "error"
      else
        $("#user_role").removeClass "require"

      # checking team id select
      if $('#user_team_id').length > 0
        if $('#user_team_id').val() > 0
          $("#reference_error").addClass "hidden"
          # return true
        else if !$('#not_school_list').is(':checked')
          $("#reference_error").removeClass "hidden"
          error = "error"
      else
        not_list = $('#not_school_list')
        if not_list.is(':checked')
          # return true
        else
          $("#reference_error").removeClass "hidden"
          error = "error"

      if error == "error"
        $("#register_error").removeClass "hidden"
        return false
      else
        $("#register_error").addClass "hidden"
        return true
