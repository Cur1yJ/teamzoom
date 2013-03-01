window.teamObject =
  setup:->
    @homeSection = $('.home')
    @teamSection = $('.find-team')
    @resetDefault()
    @clickOnGoButton()
    @clickSates()
    @clickConference()
    @clickSchool()
    @clickClose()
    @clickOnScheduleLoadingButton()
    @clickOnSaveRequest()
    @clickOnStateRegisterButton()
    @clickOnSchoolRegisterButton()
    @clickOnNotListedCheckbox()
    @clickCheck()
    @validateInput()
    @limitInput()
    @validateExpiredDateCard()
    # @parallelSubmit()

  # reset to default for all select boxes
  resetDefault: ->
    $("#payment_card").find("input:checked").removeAttr("checked")
    # @teamSection.find("#state_id option").first().attr("selected", "true")
    # @teamSection.find("#conference_id option").first().attr("selected", "true")
  # Setup click event of Save request button
  clickOnSaveRequest: ->
    @teamSection.find("#button_request").click (e) ->
      $(".find-team .error.length").addClass "none"
      if (!$(".validator").val())
        $(".find-team .error.length").removeClass "none"
        $(".find-team .error.length").html("School is required")
        return
      else
        $.ajax
          type: "POST"
          url: "/requests.json"
          dataType: "json"
          data: {request: {state: $("#state").attr("value"), team: $("#team").attr("value")} }
          success: (data)->
            $("#team").val("")
            $("#myModal1").modal("hide")
            return
          error: (errors, status)->
            $("#team").val("")
            return

  validateInput: ->
    $('.valid_number').filter_input({regex:'[0-9\r\n]', live:true})
    return

  validateExpiredDateCard: ->
    $("#order_card_expires_on_2i").live "change", () ->
      console.log 43747
      month = $("#order_card_expires_on_2i").val()
      year = $("#order_card_expires_on_1i").val()
      choose_date = new Date(year, month)
      today = new Date
      if choose_date < today
        $("#expired_error").html("The expiration date is invalid.")
      else
        $("#expired_error").html("")
    return

  limitInput: ->
    $("#order_zip_code, #order_card_verification").live "keypress", (event) ->
      key = (if event.charCode then event.charCode else (if event.keyCode then event.keyCode else 0))

      if $(this).attr("id") == "order_zip_code"
        if $(this).val().length > 4
          if !(key == 8 || key == 9 || key == 35 || key == 36|| key == 37 || key == 39 || key == 46)
            event.preventDefault()
      else if $(this).attr("id") == "order_card_verification"
        if $(this).val().length > 3
          if !(key == 8 || key == 9 || key == 35 || key == 36|| key == 37 || key == 39 || key == 46)
            event.preventDefault()
    return



  # Setup click event on close request popup
  clickClose: ->
    $(".find-team .close").click (e) ->
      $(".find-team .error.length").addClass "none"
      $("#team").val("")

  # Check validation of select boxes
  checkSelectedValues: ->
    if (this.teamSection.find("select#state_id").val() != "" && this.teamSection.find("select#conference_id").val() != "" && this.teamSection.find("select#school_id").val() != "" )
      return true
    else
      this.showErrors()
      return false

  # Show errors
  showErrors: ->
    if (this.teamSection.find("select#state_id").val() == "" )
      this.teamSection.find(".error.state").removeClass "none"
      this.teamSection.find(".error.state").html("Please choose state")
    if (this.teamSection.find("select#conference_id").val() =="" )
      this.teamSection.find(".error.conference").removeClass "none"
      this.teamSection.find(".error.conference").html("Please choose conference")
    if (this.teamSection.find("select#school_id").val() == "" )
      this.teamSection.find(".error.school").removeClass "none"
      this.teamSection.find(".error.school").html("Please choose school")

  # Click school change none
  clickSchool: ->
    $("#school_id").live "change",(e)->
      $(".find-team .error.school").addClass "none"

  # Sreach Teamzoom
  clickOnGoButton: ->
    $("#show_list").click (e) =>
      if (@checkSelectedValues()) is true
        $(".find-team .list-teams .loading").removeClass "none"
        $(".find-team .list-teams .teams").hide()
        form = $(".find-team form")
        $.ajax
          type: "GET"
          url: form.attr("action")
          data: form.serialize()
          success: (data)->
            $(".find-team .list-teams .loading").addClass "none"
            $(".find-team .list-teams .teams").html data
            $(".find-team .list-teams .teams").show()
          error: (data)->
            $(".find-team .list-teams .loading").addClass "none"
            $(".find-team .list-teams .teams").show()
      else
        false

  # sreach School
  clickConference: ->
    $("#conference_id").live "change",(e)->
      $(".find-team .error.conference").addClass "none"
      $.ajax
        type: "GET"
        url: "schools/search"
        data: {conference_id: $("#conference_id").attr("value")}
        success: (data)->
          $("#school").html data
          $(".find-team .list-teams").load()
        error: (data)->
          $("#school").html data
          $(".find-team .list-teams").load()

  # Sreach Conference
  clickSates: ->
    $("#state_id").change (e)->
      $(".find-team .error.state").addClass "none"
      $.ajax
        type: "GET"
        url: "conferences/search"
        data: {state_id: $("#state_id").attr("value")}
        success: (data)->
          $("#conference").html data
          $("#school").show()
          $(".find-team .list-teams").load()
        error: (data)->
          $("#conference").html data
          $("#school").html data

  clickOnScheduleLoadingButton: ->
    $("#post_select_team_id").change ->
      $(".ajax-loading").removeClass "hidden"
    $("#previous_date, #select_date_of_week, #next_date").click ->
      $(".ajax-loading").removeClass "hidden"

  # user register form conference and state and school selection and as well as edit user.
  clickOnStateRegisterButton: ->
    states = $("#state_id_regist").html()

    conferences = $("#conference_id_regist").html()
    schools = $("#school_id_regist").html()
    $("#new_user #conference_id_regist").empty()
    $("#new_user #school_id_regist").empty()

    edit_user_con_val = $("#edit_user #conference_id_regist").val()
    edit_user_con_text = $("#edit_user #conference_id_regist :selected").text()
    edit_user_sch_val = $("#edit_user #school_id_regist").val()
    edit_user_sch_text = $("#edit_user #school_id_regist :selected").text()

    if $("#not_school_list").is(":checked")
      $("#edit_user #conference_id_regist").html("<option val = ''>Choose Conference</option>")
      $("#edit_user #school_id_regist").html("<option val = ''>Choose School</option>")
    else
      $("#edit_user #conference_id_regist").html("<option val = '#{edit_user_con_val}'>#{edit_user_con_text}</option>")
      $("#edit_user #school_id_regist").html("<option val = '#{edit_user_sch_val}'>#{edit_user_sch_text}</option>")

    $("#state_id_regist").live "change", ->
      selected_state = $("#state_id_regist :selected").text()
      $('#user_team_id').removeAttr("value")
      filtered_conferences = $(conferences).filter("optgroup[label='#{selected_state}']").html()
      if filtered_conferences
        $("#conference_id_regist").html("<option val = ''>Choose Conference</option>"+filtered_conferences)
        $("#conference_id_regist").live "change", ->
          $('#user_team_id').removeAttr("value")
          selected_conference = $("#conference_id_regist :selected").text()
          filtered_schools = $(schools).filter("optgroup[label='#{selected_conference}']").html()
          if filtered_schools
            $("#school_id_regist").html("<option val = ''>Choose School</option>"+filtered_schools)
          else
            $("#school_id_regist").empty()
      else
        $("#conference_id_regist").empty()
        $("#school_id_regist").empty()

  clickOnSchoolRegisterButton: ->
    $('#school_id_regist').live "change", ->
      current_school_id = $(this).val()
      # console.log $.type parseInt(current_school_id)
      if current_school_id and current_school_id isnt "Choose School"
        $.ajax
          type: "GET"
          url: "/teams/get_team_by_scholl"
          data: {school_id: current_school_id}
          success: (data)->
            $("#reference_error").addClass "hidden"
            $("#not_school_list").attr('checked', false)
            $("#not_school_list").attr('disabled', true)
            $('#team-regist-box').html data
          error: (data)->
            $("#not_school_list").attr('disabled', false)
            $('#team-regist-box').html ""
            alert "Loading error"
      else
        $("#not_school_list").attr('disabled', false)
        $('#team-regist-box').html '<input id="user_team_id" type="hidden" name="user[team_id]">'
      return

  clickOnNotListedCheckbox: ->
    $("#not_school_list").live "click", ->
      not_list = $('#not_school_list')
      if not_list.is(':checked')
        $("#reference_error").addClass "hidden"
      else
        $("#reference_error").removeClass "hidden"
  clickCheck: ->
    $("#teamsport_sport_id").live "change", ->
      # alert $("#teamsport_team_id").val()
      $.post '/find_or_initial_teamsport', {teamsport_id: $(@).val(), team_id: $("#teamsport_team_id").val()}
      return
    return
  # parallelSubmit: ->
  #   $("#input_for_venue_link").live "click", ->
  #     # console.log($(".form_for_teamsport").serializeArray())
  #     $.post '/update_venue/'+$("#teamsport_team_id").val(),$(".form_for_teamsport").serializeArray()
  #     return

  #   $("#input_for_subteams_link").live "click", ->
  #     # console.log($(".form_for_teamsport").serializeArray())
  #     $.post '/teams/'+$("#teamsport_team_id").val(),$(".form_for_venue").serializeArray()
  #     return
  #   return

jQuery ->
  $('#school_conference_id').parent().hide()
  conferences = $('#school_conference_id').html()
  console.log(conferences)
  $('#school_id').change ->
    state = $('#school_id :selected').text()
    options = $(conferences).filter("optgroup[label=#{state}]").html()
    console.log(options)
    if options
      $('#school_conference_id').html(options)
      $('#school_conference_id').parent().show()
    else
      $('#school_conference_id').empty()
      $('#school_conference_id').parent().hide()