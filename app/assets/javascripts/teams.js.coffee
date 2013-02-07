$("#button_request").click (e) ->
  $(".find-team .error.length").addClass "none"
  unless $(".validator").val()
    $(".find-team .error.length").removeClass "none"
    $(".find-team .error.length").html "School is required"
  else
    $.ajax
      data:
        request:
          state: $("#state").attr("value")
          team: $("#team").attr("value")

      success: (data) ->
        $("#team").val ""
        $("#myModal1").modal "hide"

      error: (errors, status) ->
        $("#team").val ""


window.teamObject =
  setup: ->
    @homeSection = $(".home")
    @teamSection = $(".find-team")
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

  resetDefault: ->
    $("#payment_card").find("input:checked").removeAttr "checked"

  clickOnSaveRequest: ->
    @teamSection.find("#button_request").click (e) ->
      $(".find-team .error.length").addClass "none"
      unless $(".validator").val()
        $(".find-team .error.length").removeClass "none"
        $(".find-team .error.length").html "School is required"
      else
        $.ajax
          type: "POST"
          url: "/requests.json"
          dataType: "json"
          data:
            request:
              state: $("#state").attr("value")
              team: $("#team").attr("value")

          success: (data) ->
            $("#team").val ""
            $("#myModal1").modal "hide"

          error: (errors, status) ->
            $("#team").val ""



  validateInput: ->
    $(".valid_number").filter_input
      regex: "[0-9\r\n]"
      bind: true


  validateExpiredDateCard: ->
    $("#order_card_expires_on_2i").bind "change", ->
      choose_date = undefined
      month = undefined
      today = undefined
      year = undefined
      console.log 43747
      month = $("#order_card_expires_on_2i").val()
      year = $("#order_card_expires_on_1i").val()
      choose_date = new Date(year, month)
      today = new Date
      if choose_date < today
        $("#expired_error").html "The expiration date is invalid."
      else
        $("#expired_error").html ""


  limitInput: ->
    $("#order_zip_code, #order_card_verification").bind "keypress", (event) ->
      key = undefined
      key = ((if event.charCode then event.charCode else ((if event.keyCode then event.keyCode else 0))))
      if $(this).attr("id") is "order_zip_code"
        event.preventDefault()  unless key is 8 or key is 9 or key is 35 or key is 36 or key is 37 or key is 39 or key is 46  if $(this).val().length > 4
      else event.preventDefault()  unless key is 8 or key is 9 or key is 35 or key is 36 or key is 37 or key is 39 or key is 46  if $(this).val().length > 3  if $(this).attr("id") is "order_card_verification"


  clickClose: ->
    $(".find-team .close").click (e) ->
      $(".find-team .error.length").addClass "none"
      $("#team").val ""


  checkSelectedValues: ->
    if @teamSection.find("select#state_id").val() isnt "" and @teamSection.find("select#conference_id").val() isnt "" and @teamSection.find("select#school_id").val() isnt ""
      true
    else
      @showErrors()
      false

  showErrors: ->
    if @teamSection.find("select#state_id").val() is ""
      @teamSection.find(".error.state").removeClass "none"
      @teamSection.find(".error.state").html "Please choose state"
    if @teamSection.find("select#conference_id").val() is ""
      @teamSection.find(".error.conference").removeClass "none"
      @teamSection.find(".error.conference").html "Please choose conference"
    if @teamSection.find("select#school_id").val() is ""
      @teamSection.find(".error.school").removeClass "none"
      @teamSection.find(".error.school").html "Please choose school"

  clickSchool: ->
    $("#school_id").bind "change", (e) ->
      $(".find-team .error.school").addClass "none"


  clickOnGoButton: ->
    _this = this
    $("#show_list").click (e) ->
      form = undefined
      if (_this.checkSelectedValues()) is true
        $(".find-team .list-teams .loading").removeClass "none"
        $(".find-team .list-teams .teams").hide()
        form = $(".find-team form")
        $.ajax
          type: "GET"
          url: form.attr("action")
          data: form.serialize()
          success: (data) ->
            $(".find-team .list-teams .loading").addClass "none"
            $(".find-team .list-teams .teams").html data
            $(".find-team .list-teams .teams").show()

          error: (data) ->
            $(".find-team .list-teams .loading").addClass "none"
            $(".find-team .list-teams .teams").show()

      else
        false


  clickConference: ->
    $("#conference_id").bind "change", (e) ->
      $(".find-team .error.conference").addClass "none"
      $.ajax
        type: "GET"
        url: "schools/search"
        data:
          conference_id: $("#conference_id").attr("value")

        success: (data) ->
          $("#school").html data
          $(".find-team .list-teams").load()

        error: (data) ->
          $("#school").html data
          $(".find-team .list-teams").load()



  clickSates: ->
    $("#state_id").change (e) ->
      $(".find-team .error.state").addClass "none"
      $.ajax
        type: "GET"
        url: "conferences/search"
        data:
          state_id: $("#state_id").attr("value")

        success: (data) ->
          $("#conference").html data
          $("#school").show()
          $(".find-team .list-teams").load()

        error: (data) ->
          $("#conference").html data
          $("#school").html data



  clickOnScheduleLoadingButton: ->
    $("#post_select_team_id").change ->
      $(".ajax-loading").removeClass "hidden"

    $("#previous_date, #select_date_of_week, #next_date").click ->
      $(".ajax-loading").removeClass "hidden"


  clickOnStateRegisterButton: ->
    conferences = undefined
    edit_user_con_text = undefined
    edit_user_con_val = undefined
    edit_user_sch_text = undefined
    edit_user_sch_val = undefined
    schools = undefined
    states = undefined
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
      $("#edit_user #conference_id_regist").html "<option val = ''>Choose Conference</option>"
      $("#edit_user #school_id_regist").html "<option val = ''>Choose School</option>"
    else
      $("#edit_user #conference_id_regist").html "<option val = '" + edit_user_con_val + "'>" + edit_user_con_text + "</option>"
      $("#edit_user #school_id_regist").html "<option val = '" + edit_user_sch_val + "'>" + edit_user_sch_text + "</option>"
    $("#state_id_regist").bind "change", ->
      filtered_conferences = undefined
      selected_state = undefined
      selected_state = $("#state_id_regist :selected").text()
      $("#user_team_id").removeAttr "value"
      filtered_conferences = $(conferences).filter("optgroup[label='" + selected_state + "']").html()
      if filtered_conferences
        $("#conference_id_regist").html "<option val = ''>Choose Conference</option>" + filtered_conferences
        $("#conference_id_regist").bind "change", ->
          filtered_schools = undefined
          selected_conference = undefined
          $("#user_team_id").removeAttr "value"
          selected_conference = $("#conference_id_regist :selected").text()
          filtered_schools = $(schools).filter("optgroup[label='" + selected_conference + "']").html()
          if filtered_schools
            $("#school_id_regist").html "<option val = ''>Choose School</option>" + filtered_schools
          else
            $("#school_id_regist").empty()

      else
        $("#conference_id_regist").empty()
        $("#school_id_regist").empty()


  clickOnSchoolRegisterButton: ->
    $("#school_id_regist").bind "change", ->
      current_school_id = undefined
      current_school_id = $(this).val()
      if current_school_id and current_school_id isnt "Choose School"
        $.ajax
          type: "GET"
          url: "/teams/get_team_by_scholl"
          data:
            school_id: current_school_id

          success: (data) ->
            $("#reference_error").addClass "hidden"
            $("#not_school_list").attr "checked", false
            $("#not_school_list").attr "disabled", true
            $("#team-regist-box").html data

          error: (data) ->
            $("#not_school_list").attr "disabled", false
            $("#team-regist-box").html ""
            alert "Loading error"

      else
        $("#not_school_list").attr "disabled", false
        $("#team-regist-box").html "<input id=\"user_team_id\" type=\"hidden\" name=\"user[team_id]\">"


  clickOnNotListedCheckbox: ->
    $("#not_school_list").bind "click", ->
      not_list = undefined
      not_list = $("#not_school_list")
      if not_list.is(":checked")
        $("#reference_error").addClass "hidden"
      else
        $("#reference_error").removeClass "hidden"


  clickCheck: ->
    $("#teamsport_sport_id").bind "change", ->
      $.post "/find_or_initial_teamsport",
        teamsport_id: $(this).val()
        team_id: $("#teamsport_team_id").val()


