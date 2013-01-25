window.scheduleObject =
  setup:->
    @picker()
    @loadSelect()
    @pickerSchedule()
    @checkValidate()
    @loadSport()
    @loadVenues()

  picker: ->
    $("#from_date").datepicker({"format": "dd-mm-yyyy"})
    $("#end_date").datepicker({"format": "dd-mm-yyyy"})

  checkValidate: ->
    $('#save_schedule').live "click", (e) ->
      start_time_hour = parseInt $("#schedule_start_time_4i").val(), 10
      console.log start_time_hour
      end_time_hour = parseInt $("#schedule_end_time_4i").val(), 10
      console.log end_time_hour
      console.log start_time_hour > end_time_hour
      if start_time_hour > end_time_hour
        $("#start_time_error").html("Start time must be less than end time")
        return false
      else
        if start_time_hour == end_time_hour
          start_time_minute = parseInt $("#schedule_start_time_5i").val(), 10
          end_time_minute = parseInt $("#schedule_end_time_5i").val(), 10
          if start_time_minute >= end_time_minute
            $("#start_time_error").html("Start time must be less than end time")
            return false
          else
            $("#start_time_error").html("")
        else
          $("#start_time_error").html("")

      $("#edit_team").bind "ajax:before", (et, e) ->
        $('#save_schedule').attr("disabled","disabled")

      if $("#schedule_sport_id").val() == ""
        $("#sport_error").html("can't be blank")
        return false
      else
        $("#team_error").html("")
      if $("#schedule_subteam_home_team_id").val() == "" || $("#schedule_subteam_home_team_id").val() == "0"
        $("#team_error").html("can't be blank")
        return false
      else
        $("#team_error").html("")

      if $("#schedule_subteam_opponent_team_id").val() == "" || $("#schedule_subteam_opponent_team_id").val() == "0"
        $("#team_opponent_error").html("can't be blank")
        return false
      else
        $("#team_opponent_error").html("")

      if $("#schedule_subteam_opponent_team_id").val() == $("#schedule_subteam_home_team_id").val()
        $("#team_opponent_error").html("can't choose the same home and away")
        return false
      else
        $("#team_opponent_error").html("")
      return



  pickerSchedule: ->
    $("#schedule_event_date").live "focus", (e) ->
      $("#schedule_event_date").datepicker({"format": "dd-mm-yyyy"});

  loadSelect: ->
    $("#schedule_subteam_home_team_id").live "change", (e) ->
      options = "<option value=0>Select one</option>"
      $("#schedule_subteam_id option").remove()
      if $("#schedule_subteam_home_team_id").val() == ""
        $("#schedule_subteam_id").append(options)
      else
        $.ajax
          type: "GET"
          url: "/load_subteams"
          data: {team: $(this).attr("value"), sport_id: $("#schedule_sport_id").attr("value")}
          success: (data)->
            i = 0
            while i < data.length
              options += "<option value=" + data[i]["id"] + ">" + data[i]["name"] + "</option>"
              i++
            $("#schedule_subteam_id").append(options)
            return
          error: (errors, status)->
            return
     $("#schedule_subteam_opponent_team_id").live "change", (e) ->
      options = "<option value=0>Select one</option>"
      $("#schedule_opponent_id option").remove()
      if $("#schedule_subteam_opponent_team_id").val() == ""
        $("#schedule_opponent_id").append(options)
      else
        $.ajax
          type: "GET"
          url: "/load_subteams"
          data: {team: $(this).attr("value"), sport_id: $("#schedule_sport_id").attr("value")}
          success: (data)->
            i = 0
            while i < data.length
              options += "<option value=" + data[i]["id"] + ">" + data[i]["name"] + "</option>"
              i++
            $("#schedule_opponent_id").append(options)
            return
          error: (errors, status)->
            return
  loadSport: ->
    $("#schedule_sport_id").live "change", (e) ->
      option_subteams = "<option value=0>Select one</option>"
      option_teams = option_subteams
      $("#schedule_subteam_id option").remove()
      $("#schedule_opponent_id option").remove()
      $("#schedule_subteam_opponent_team_id option").remove()
      $("#schedule_subteam_home_team_id option").remove()
      if $("#schedule_sport_id").val() == ""
        $("#schedule_subteam_id").append(option_subteams)
        $("#schedule_opponent_id").append(option_subteams)
        $("#schedule_subteam_home_team_id").append(option_teams)
        $("#schedule_subteam_opponent_team_id").append(option_teams)

      else
        $.ajax
          type: "GET"
          url: "/load_teams_for_sport"
          data: {sport_id: $(this).attr("value")}
          success: (data)->
            subs = data[0]
            teams = data[1]
            i = 0
            while i < subs.length
              option_subteams += "<option value=" + subs[i]["id"] + ">" + subs[i]["name"] + "</option>"
              i++
            $("#schedule_subteam_id").append(option_subteams)
            $("#schedule_opponent_id").append(option_subteams)

            j = 0
            while j < teams.length
              option_teams += "<option value=" + teams[j]["id"] + ">" + teams[j]["name"] + "</option>"
              j++
            $("#schedule_subteam_home_team_id").append(option_teams)
            $("#schedule_subteam_opponent_team_id").append(option_teams)
            return
          error: (errors, status)->
            return
  loadVenues: ->
    $("#schedule_subteam_home_team_id").live "change", () ->
      options = "<option value=0>Select one</option>"
      $("#schedule_venue_id option").remove()
      if $(this).val() == ""
        $("#schedule_venue_id").append(options)
      else
        $.ajax
          type: "GET"
          url: "/load_venues"
          data: {team_id: $(this).val()}
          success: (data)->
            i = 0
            while i < data.length
              options += "<option value=" + data[i]["id"] + ">" + data[i]["venue"] + "</option>"
              i++
            $("#schedule_venue_id").append(options)
            return
          error: (errors, status)->
            return
    return


