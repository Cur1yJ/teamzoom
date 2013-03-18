ClientSideValidations.formBuilders['SimpleForm::FormBuilder'] = {
		add: function(element, settings, message) {
				var errorElement, wrapper;

				settings.wrapper_tag = ".control-group";
				settings.error_tag = "span";
				settings.error_class = "help-inline";
				settings.wrapper_error_class = "error";

				if (element.data('valid') !== false) {
						wrapper = element.closest(settings.wrapper_tag);
						wrapper.addClass(settings.wrapper_error_class);
						errorElement = $("<" + settings.error_tag + "/>", {
								"class": settings.error_class,
								text: message
						});
						return wrapper.find(".controls").append(errorElement);
				} else {
						return element.parent().find("" + settings.error_tag + "." + settings.error_class).text(message);
				}
		},
		remove: function(element, settings) {
				var errorElement, wrapper;

				settings.wrapper_tag = ".control-group";
				settings.error_tag = "span";
				settings.error_class = "help-inline";
				settings.wrapper_error_class = "error";

				wrapper = element.closest("" + settings.wrapper_tag + "." + settings.wrapper_error_class);
				wrapper.removeClass(settings.wrapper_error_class);
				errorElement = wrapper.find("" + settings.error_tag + "." + settings.error_class);
				return errorElement.remove();
		}
};
(function() {

  Cufon.replace('h2', {
    color: 'green',
    letterSpacing: '-1px',
    fontSize: '18px'
  });

  Cufon.replace('label.label_input', {
    color: '#000000'
  });

}).call(this);
(function() {

  window.homeObject = {
    setup: function() {
      this.homeSection = $(".home");
      this.video_pop();
    },
    video_pop: function() {
      $("#video").on("show", function() {
        $("#video div.modal-body").html('<iframe src="http://www.youtube.com/v/Exd7nqV5-cE&amp;rel=0&amp;autohide=1&amp;showinfo=0&amp;autoplay=1" width="500" height="281" frameborder="0" allowfullscreen=""></iframe>');
      });
    }
  };

}).call(this);
(function() {

  $(function() {
    homeObject.setup();
    teamObject.setup();
    transactionObject.setup();
    scheduleObject.setup();
  });

}).call(this);
(function() {



}).call(this);
(function() {
  var CARDNUM_VALIDATOR, CVV;

  CARDNUM_VALIDATOR = void 0;

  CVV = void 0;

  CARDNUM_VALIDATOR = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/;

  CVV = /^\d*$/;

  window.CARD_TYPE_VALIDATORS = [
    {
      value: "USA_express",
      reg: /^3[47][0-9]{13}$/
    }, {
      value: "discover",
      reg: /^6(?:011|5[0-9]{2})[0-9]{12}$/
    }, {
      value: "visa",
      reg: /^4[0-9]{12}(?:[0-9]{3})?$/
    }, {
      value: "jcb",
      reg: /^(?:2131|1800|35\d{3})\d{11}$/
    }, {
      value: "dinners_club",
      reg: /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/
    }, {
      value: "master_card",
      reg: /^5[1-5][0-9]{14}$/
    }
  ];

  $("#choose_popup").modal({
    backdrop: "static"
  });

  $(".btn_ok").bind("click", function() {
    return location.reload();
  });

  $(".icon-credit-card").bind("click", function() {
    var id_name, radio;
    id_name = void 0;
    radio = void 0;
    $(".icon-credit-card").removeClass("selected");
    $(this).addClass("selected");
    id_name = $(this).parent().attr("for");
    return radio = $("#" + id_name).attr("checked", "checked");
  });

  $("#btn_payment").bind("click", function() {
    if ($("#term_of_use").attr("checked") === "checked" || $("#term_of_use").val() === "true") {
      $("#btn_payment").attr("disabled", "disabled");
      $("#warning-term").html("");
      return $("#payment_form").submit();
    } else {
      $("#warning-term").html("Please accept the Team of use.");
      return false;
    }
  });

  $("#agree_payment").bind("click", function() {
    $("#payment_options").modal("hide");
    return $("#options-form").submit();
  });

  $("#cvv-popup").bind("hover", function() {
    return $("#cvv-popup").popover({
      title: null,
      html: "true",
      content: "<img src=\"/assets/cvv.png\" alt=\"Cvv\">",
      trigger: "hover"
    });
  });

  $("#options").bind("click", function() {
    if ($("#options input[type='radio']:checked").val() === "false") {
      $("#introduce-monthly").show();
      return $("#introduce-individual").hide();
    } else {
      $("#introduce-individual").show();
      return $("#introduce-monthly").hide();
    }
  });

  $("#choose_option").click(function() {
    var option_value;
    option_value = void 0;
    option_value = $("#choose input[type=radio]:checked").val();
    if (option_value === "monthly") {
      return $("#choose_popup").modal("hide");
    } else {
      if (option_value === "individual") {
        return window.location.href = "/teams/find_team";
      }
    }
  });

  $("#order_card_number").change(function() {
    var card_type, validator, _i, _len, _results;
    card_type = void 0;
    validator = void 0;
    _i = void 0;
    _len = void 0;
    card_type = $("#payment_card").find("input:checked");
    if (card_type.length === 0) {
      return $("#type_error").html("Please choose card type!");
    } else {
      _i = 0;
      _len = CARD_TYPE_VALIDATORS.length;
      _results = [];
      while (_i < _len) {
        validator = CARD_TYPE_VALIDATORS[_i];
        if (validator.value === card_type) {
          if (!validator.reg.test($(this).val())) {
            $("#card_error").html("Your card number does not match this card_type!");
          } else {
            $("#card_error").html("");
            $("#type_error").html("");
          }
        }
        _results.push(_i++);
      }
      return _results;
    }
  });

  $("#payment_card").find("input").bind("click", function() {
    var card_num, validator, _i, _len, _results;
    card_num = void 0;
    validator = void 0;
    _i = void 0;
    _len = void 0;
    card_num = $("#order_card_number").val();
    console.log($(this).val());
    console.log(card_num);
    _i = 0;
    _len = CARD_TYPE_VALIDATORS.length;
    _results = [];
    while (_i < _len) {
      validator = CARD_TYPE_VALIDATORS[_i];
      if (validator.value === $(this).val()) {
        if (card_num !== "" && !validator.reg.test(card_num)) {
          $("#card_error").html("Your card number does not match this card_type!");
        } else {
          $("#card_error").html("");
        }
      }
      _results.push(_i++);
    }
    return _results;
  });

  $("#order_card_verification").blur(function() {
    var cvv;
    cvv = void 0;
    cvv = $("#order_card_verification").val();
    if (!CVV.test(cvv)) {
      return $("#cvv_error").html("Your card verification value is invalid!");
    } else {
      return $("#cvv_error").html("");
    }
  });

  $("#request_payment").click(function() {
    return $("#check_login").modal("hide");
  });

  $("#post_select_team_id").change(function() {
    return $.ajax({
      type: "GET",
      url: "/show_sport",
      data: {
        sport: $(this).attr("value"),
        team_id: $("#current_team_id").val()
      },
      success: function(data) {
        $(".ajax-loading").addClass("hidden");
        return $("#schedule-data-table").html(data);
      },
      error: function(errors, status) {
        return $(".ajax-loading").addClass("hidden");
      }
    });
  });

  $("#close_payment").click(function() {
    $("#type_error").html("");
    $("#card_error").html("");
    $("#cvv_error").html("");
    $("#firstname_error").html("");
    $("#lastname_error").html("");
    $("#address_error").html("");
    $("#city_error").html("");
    return $("#zip_code_error").html("");
  });

}).call(this);
(function() {

  window.scheduleObject = {
    setup: function() {
      this.picker();
      this.loadSelect();
      this.pickerSchedule();
      this.checkValidate();
      this.loadSport();
      return this.loadVenues();
    },
    picker: function() {
      $("#from_date").datepicker({
        "format": "dd-mm-yyyy"
      });
      return $("#end_date").datepicker({
        "format": "dd-mm-yyyy"
      });
    },
    checkValidate: function() {
      return $('#save_schedule').live("click", function(e) {
        var end_time_hour, end_time_minute, start_time_hour, start_time_minute;
        start_time_hour = parseInt($("#schedule_start_time_4i").val(), 10);
        console.log(start_time_hour);
        end_time_hour = parseInt($("#schedule_end_time_4i").val(), 10);
        console.log(end_time_hour);
        console.log(start_time_hour > end_time_hour);
        if (start_time_hour > end_time_hour) {
          $("#start_time_error").html("Start time must be less than end time");
          return false;
        } else {
          if (start_time_hour === end_time_hour) {
            start_time_minute = parseInt($("#schedule_start_time_5i").val(), 10);
            end_time_minute = parseInt($("#schedule_end_time_5i").val(), 10);
            if (start_time_minute >= end_time_minute) {
              $("#start_time_error").html("Start time must be less than end time");
              return false;
            } else {
              $("#start_time_error").html("");
            }
          } else {
            $("#start_time_error").html("");
          }
        }
        $("#edit_team").bind("ajax:before", function(et, e) {
          return $('#save_schedule').attr("disabled", "disabled");
        });
        if ($("#schedule_sport_id").val() === "") {
          $("#sport_error").html("can't be blank");
          return false;
        } else {
          $("#team_error").html("");
        }
        if ($("#schedule_subteam_home_team_id").val() === "" || $("#schedule_subteam_home_team_id").val() === "0") {
          $("#team_error").html("can't be blank");
          return false;
        } else {
          $("#team_error").html("");
        }
        if ($("#schedule_subteam_opponent_team_id").val() === "" || $("#schedule_subteam_opponent_team_id").val() === "0") {
          $("#team_opponent_error").html("can't be blank");
          return false;
        } else {
          $("#team_opponent_error").html("");
        }
        if ($("#schedule_subteam_opponent_team_id").val() === $("#schedule_subteam_home_team_id").val()) {
          $("#team_opponent_error").html("can't choose the same home and away");
          return false;
        } else {
          $("#team_opponent_error").html("");
        }
      });
    },
    pickerSchedule: function() {
      return $("#schedule_event_date").live("focus", function(e) {
        return $("#schedule_event_date").datepicker({
          "format": "dd-mm-yyyy"
        });
      });
    },
    loadSelect: function() {
      $("#schedule_subteam_home_team_id").live("change", function(e) {
        var options;
        options = "<option value=0>Select one</option>";
        $("#schedule_subteam_id option").remove();
        if ($("#schedule_subteam_home_team_id").val() === "") {
          return $("#schedule_subteam_id").append(options);
        } else {
          return $.ajax({
            type: "GET",
            url: "/load_subteams",
            data: {
              team: $(this).attr("value"),
              sport_id: $("#schedule_sport_id").attr("value")
            },
            success: function(data) {
              var i;
              i = 0;
              while (i < data.length) {
                options += "<option value=" + data[i]["id"] + ">" + data[i]["name"] + "</option>";
                i++;
              }
              $("#schedule_subteam_id").append(options);
            },
            error: function(errors, status) {}
          });
        }
      });
      return $("#schedule_subteam_opponent_team_id").live("change", function(e) {
        var options;
        options = "<option value=0>Select one</option>";
        $("#schedule_opponent_id option").remove();
        if ($("#schedule_subteam_opponent_team_id").val() === "") {
          return $("#schedule_opponent_id").append(options);
        } else {
          return $.ajax({
            type: "GET",
            url: "/load_subteams",
            data: {
              team: $(this).attr("value"),
              sport_id: $("#schedule_sport_id").attr("value")
            },
            success: function(data) {
              var i;
              i = 0;
              while (i < data.length) {
                options += "<option value=" + data[i]["id"] + ">" + data[i]["name"] + "</option>";
                i++;
              }
              $("#schedule_opponent_id").append(options);
            },
            error: function(errors, status) {}
          });
        }
      });
    },
    loadSport: function() {
      return $("#schedule_sport_id").live("change", function(e) {
        var option_subteams, option_teams;
        option_subteams = "<option value=0>Select one</option>";
        option_teams = option_subteams;
        $("#schedule_subteam_id option").remove();
        $("#schedule_opponent_id option").remove();
        $("#schedule_subteam_opponent_team_id option").remove();
        $("#schedule_subteam_home_team_id option").remove();
        if ($("#schedule_sport_id").val() === "") {
          $("#schedule_subteam_id").append(option_subteams);
          $("#schedule_opponent_id").append(option_subteams);
          $("#schedule_subteam_home_team_id").append(option_teams);
          return $("#schedule_subteam_opponent_team_id").append(option_teams);
        } else {
          return $.ajax({
            type: "GET",
            url: "/load_teams_for_sport",
            data: {
              sport_id: $(this).attr("value")
            },
            success: function(data) {
              var i, j, subs, teams;
              subs = data[0];
              teams = data[1];
              i = 0;
              while (i < subs.length) {
                option_subteams += "<option value=" + subs[i]["id"] + ">" + subs[i]["name"] + "</option>";
                i++;
              }
              $("#schedule_subteam_id").append(option_subteams);
              $("#schedule_opponent_id").append(option_subteams);
              j = 0;
              while (j < teams.length) {
                option_teams += "<option value=" + teams[j]["id"] + ">" + teams[j]["name"] + "</option>";
                j++;
              }
              $("#schedule_subteam_home_team_id").append(option_teams);
              $("#schedule_subteam_opponent_team_id").append(option_teams);
            },
            error: function(errors, status) {}
          });
        }
      });
    },
    loadVenues: function() {
      $("#schedule_subteam_home_team_id").live("change", function() {
        var options;
        options = "<option value=0>Select one</option>";
        $("#schedule_venue_id option").remove();
        if ($(this).val() === "") {
          return $("#schedule_venue_id").append(options);
        } else {
          return $.ajax({
            type: "GET",
            url: "/load_venues",
            data: {
              team_id: $(this).val()
            },
            success: function(data) {
              var i;
              i = 0;
              while (i < data.length) {
                options += "<option value=" + data[i]["id"] + ">" + data[i]["venue"] + "</option>";
                i++;
              }
              $("#schedule_venue_id").append(options);
            },
            error: function(errors, status) {}
          });
        }
      });
    }
  };

}).call(this);
(function() {

  $('#example1').popover('hide');

  $('#example2').popover('hide');

  $('#example3').popover('hide');

  $('#example4').popover('hide');

  $('#example5').popover('hide');

  $('#make_error').modal({
    backdrop: true
  });

}).call(this);
(function() {

  window.teamObject = {
    setup: function() {
      this.homeSection = $('.home');
      this.teamSection = $('.find-team');
      this.resetDefault();
      this.clickOnGoButton();
      this.clickSates();
      this.clickConference();
      this.clickSchool();
      this.clickClose();
      this.clickOnScheduleLoadingButton();
      this.clickOnSaveRequest();
      this.clickOnStateRegisterButton();
      this.clickOnSchoolRegisterButton();
      this.clickOnNotListedCheckbox();
      this.clickCheck();
      this.validateInput();
      this.limitInput();
      return this.validateExpiredDateCard();
    },
    resetDefault: function() {
      return $("#payment_card").find("input:checked").removeAttr("checked");
    },
    clickOnSaveRequest: function() {
      return this.teamSection.find("#button_request").click(function(e) {
        $(".find-team .error.length").addClass("none");
        if (!$(".validator").val()) {
          $(".find-team .error.length").removeClass("none");
          $(".find-team .error.length").html("School is required");
        } else {
          return $.ajax({
            type: "POST",
            url: "/requests.json",
            dataType: "json",
            data: {
              request: {
                state: $("#state").attr("value"),
                team: $("#team").attr("value")
              }
            },
            success: function(data) {
              $("#team").val("");
              $("#myModal1").modal("hide");
            },
            error: function(errors, status) {
              $("#team").val("");
            }
          });
        }
      });
    },
    validateInput: function() {
      $('.valid_number').filter_input({
        regex: '[0-9\r\n]',
        live: true
      });
    },
    validateExpiredDateCard: function() {
      $("#order_card_expires_on_2i").live("change", function() {
        var choose_date, month, today, year;
        console.log(43747);
        month = $("#order_card_expires_on_2i").val();
        year = $("#order_card_expires_on_1i").val();
        choose_date = new Date(year, month);
        today = new Date;
        if (choose_date < today) {
          return $("#expired_error").html("The expiration date is invalid.");
        } else {
          return $("#expired_error").html("");
        }
      });
    },
    limitInput: function() {
      $("#order_zip_code, #order_card_verification").live("keypress", function(event) {
        var key;
        key = (event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0));
        if ($(this).attr("id") === "order_zip_code") {
          if ($(this).val().length > 4) {
            if (!(key === 8 || key === 9 || key === 35 || key === 36 || key === 37 || key === 39 || key === 46)) {
              return event.preventDefault();
            }
          }
        } else if ($(this).attr("id") === "order_card_verification") {
          if ($(this).val().length > 3) {
            if (!(key === 8 || key === 9 || key === 35 || key === 36 || key === 37 || key === 39 || key === 46)) {
              return event.preventDefault();
            }
          }
        }
      });
    },
    clickClose: function() {
      return $(".find-team .close").click(function(e) {
        $(".find-team .error.length").addClass("none");
        return $("#team").val("");
      });
    },
    checkSelectedValues: function() {
      if (this.teamSection.find("select#state_id").val() !== "" && this.teamSection.find("select#conference_id").val() !== "" && this.teamSection.find("select#school_id").val() !== "") {
        return true;
      } else {
        this.showErrors();
        return false;
      }
    },
    showErrors: function() {
      if (this.teamSection.find("select#state_id").val() === "") {
        this.teamSection.find(".error.state").removeClass("none");
        this.teamSection.find(".error.state").html("Please choose state");
      }
      if (this.teamSection.find("select#conference_id").val() === "") {
        this.teamSection.find(".error.conference").removeClass("none");
        this.teamSection.find(".error.conference").html("Please choose conference");
      }
      if (this.teamSection.find("select#school_id").val() === "") {
        this.teamSection.find(".error.school").removeClass("none");
        return this.teamSection.find(".error.school").html("Please choose school");
      }
    },
    clickSchool: function() {
      return $("#school_id").live("change", function(e) {
        return $(".find-team .error.school").addClass("none");
      });
    },
    clickOnGoButton: function() {
      var _this = this;
      return $("#show_list").click(function(e) {
        var form;
        if ((_this.checkSelectedValues()) === true) {
          $(".find-team .list-teams .loading").removeClass("none");
          $(".find-team .list-teams .teams").hide();
          form = $(".find-team form");
          return $.ajax({
            type: "GET",
            url: form.attr("action"),
            data: form.serialize(),
            success: function(data) {
              $(".find-team .list-teams .loading").addClass("none");
              $(".find-team .list-teams .teams").html(data);
              return $(".find-team .list-teams .teams").show();
            },
            error: function(data) {
              $(".find-team .list-teams .loading").addClass("none");
              return $(".find-team .list-teams .teams").show();
            }
          });
        } else {
          return false;
        }
      });
    },
    clickConference: function() {
      return $("#conference_id").live("change", function(e) {
        $(".find-team .error.conference").addClass("none");
        return $.ajax({
          type: "GET",
          url: "schools/search",
          data: {
            conference_id: $("#conference_id").attr("value")
          },
          success: function(data) {
            $("#school").html(data);
            return $(".find-team .list-teams").load();
          },
          error: function(data) {
            $("#school").html(data);
            return $(".find-team .list-teams").load();
          }
        });
      });
    },
    clickSates: function() {
      return $("#state_id").change(function(e) {
        $(".find-team .error.state").addClass("none");
        return $.ajax({
          type: "GET",
          url: "conferences/search",
          data: {
            state_id: $("#state_id").attr("value")
          },
          success: function(data) {
            $("#conference").html(data);
            $("#school").show();
            return $(".find-team .list-teams").load();
          },
          error: function(data) {
            $("#conference").html(data);
            return $("#school").html(data);
          }
        });
      });
    },
    clickOnScheduleLoadingButton: function() {
      $("#post_select_team_id").change(function() {
        return $(".ajax-loading").removeClass("hidden");
      });
      return $("#previous_date, #select_date_of_week, #next_date").click(function() {
        return $(".ajax-loading").removeClass("hidden");
      });
    },
    clickOnStateRegisterButton: function() {
      var conferences, edit_user_con_text, edit_user_con_val, edit_user_sch_text, edit_user_sch_val, schools, states;
      states = $("#state_id_regist").html();
      conferences = $("#conference_id_regist").html();
      schools = $("#school_id_regist").html();
      $("#new_user #conference_id_regist").empty();
      $("#new_user #school_id_regist").empty();
      edit_user_con_val = $("#edit_user #conference_id_regist").val();
      edit_user_con_text = $("#edit_user #conference_id_regist :selected").text();
      edit_user_sch_val = $("#edit_user #school_id_regist").val();
      edit_user_sch_text = $("#edit_user #school_id_regist :selected").text();
      if ($("#not_school_list").is(":checked")) {
        $("#edit_user #conference_id_regist").html("<option val = ''>Choose Conference</option>");
        $("#edit_user #school_id_regist").html("<option val = ''>Choose School</option>");
      } else {
        $("#edit_user #conference_id_regist").html("<option val = '" + edit_user_con_val + "'>" + edit_user_con_text + "</option>");
        $("#edit_user #school_id_regist").html("<option val = '" + edit_user_sch_val + "'>" + edit_user_sch_text + "</option>");
      }
      return $("#state_id_regist").live("change", function() {
        var filtered_conferences, selected_state;
        selected_state = $("#state_id_regist :selected").text();
        $('#user_team_id').removeAttr("value");
        filtered_conferences = $(conferences).filter("optgroup[label='" + selected_state + "']").html();
        if (filtered_conferences) {
          $("#conference_id_regist").html("<option val = ''>Choose Conference</option>" + filtered_conferences);
          return $("#conference_id_regist").live("change", function() {
            var filtered_schools, selected_conference;
            $('#user_team_id').removeAttr("value");
            selected_conference = $("#conference_id_regist :selected").text();
            filtered_schools = $(schools).filter("optgroup[label='" + selected_conference + "']").html();
            if (filtered_schools) {
              return $("#school_id_regist").html("<option val = ''>Choose School</option>" + filtered_schools);
            } else {
              return $("#school_id_regist").empty();
            }
          });
        } else {
          $("#conference_id_regist").empty();
          return $("#school_id_regist").empty();
        }
      });
    },
    clickOnSchoolRegisterButton: function() {
      return $('#school_id_regist').live("change", function() {
        var current_school_id;
        current_school_id = $(this).val();
        if (current_school_id && current_school_id !== "Choose School") {
          $.ajax({
            type: "GET",
            url: "/teams/get_team_by_scholl",
            data: {
              school_id: current_school_id
            },
            success: function(data) {
              $("#reference_error").addClass("hidden");
              $("#not_school_list").attr('checked', false);
              $("#not_school_list").attr('disabled', true);
              return $('#team-regist-box').html(data);
            },
            error: function(data) {
              $("#not_school_list").attr('disabled', false);
              $('#team-regist-box').html("");
              return alert("Loading error");
            }
          });
        } else {
          $("#not_school_list").attr('disabled', false);
          $('#team-regist-box').html('<input id="user_team_id" type="hidden" name="user[team_id]">');
        }
      });
    },
    clickOnNotListedCheckbox: function() {
      return $("#not_school_list").live("click", function() {
        var not_list;
        not_list = $('#not_school_list');
        if (not_list.is(':checked')) {
          return $("#reference_error").addClass("hidden");
        } else {
          return $("#reference_error").removeClass("hidden");
        }
      });
    },
    clickCheck: function() {
      $("#teamsport_sport_id").live("change", function() {
        $.post('/find_or_initial_teamsport', {
          teamsport_id: $(this).val(),
          team_id: $("#teamsport_team_id").val()
        });
      });
    }
  };

  jQuery(function() {
    var conferences, schools;
    $('#school_conference_id').parent().hide();
    $('#school_id').parent().hide();
    conferences = $('#school_conference_id').html();
    schools = $('#school_id').html();
    $('#state_id').change(function() {
      var conf_options, escaped_state, state;
      state = $('#state_id :selected').text();
      escaped_state = state.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
      conf_options = $(conferences).filter("optgroup[label=" + escaped_state + "]").html();
      if (conf_options) {
        return $('#school_conference_id').html(conf_options).parent().show();
      } else {
        $('#school_conference_id').empty().parent().hide();
        return $('#school_id').empty().parent().hide();
      }
    });
    return $('#school_conference_id').change(function() {
      var conference, escaped_conference, school_options;
      conference = $('#school_conference_id :selected').text();
      escaped_conference = conference.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
      school_options = $(schools).filter("optgroup[label=" + escaped_conference + "]").html();
      if (school_options) {
        return $('#school_id').html(school_options).parent().show();
      } else {
        return $('#school_id').empty().parent().hide();
      }
    });
  });

}).call(this);
(function() {



}).call(this);
// This [jQuery](http://jquery.com/) plugin implements an `<iframe>`
// [transport](http://api.jquery.com/extending-ajax/#Transports) so that
// `$.ajax()` calls support the uploading of files using standard HTML file
// input fields. This is done by switching the exchange from `XMLHttpRequest` to
// a hidden `iframe` element containing a form that is submitted.

// The [source for the plugin](http://github.com/cmlenz/jquery-iframe-transport)
// is available on [Github](http://github.com/) and dual licensed under the MIT
// or GPL Version 2 licenses.

// ## Usage

// To use this plugin, you simply add a `iframe` option with the value `true`
// to the Ajax settings an `$.ajax()` call, and specify the file fields to
// include in the submssion using the `files` option, which can be a selector,
// jQuery object, or a list of DOM elements containing one or more
// `<input type="file">` elements:

//     $("#myform").submit(function() {
//         $.ajax(this.action, {
//             files: $(":file", this),
//             iframe: true
//         }).complete(function(data) {
//             console.log(data);
//         });
//     });

// The plugin will construct a hidden `<iframe>` element containing a copy of
// the form the file field belongs to, will disable any form fields not
// explicitly included, submit that form, and process the response.

// If you want to include other form fields in the form submission, include them
// in the `data` option, and set the `processData` option to `false`:

//     $("#myform").submit(function() {
//         $.ajax(this.action, {
//             data: $(":text", this).serializeArray(),
//             files: $(":file", this),
//             iframe: true,
//             processData: false
//         }).complete(function(data) {
//             console.log(data);
//         });
//     });

// ### The Server Side

// If the response is not HTML or XML, you (unfortunately) need to apply some
// trickery on the server side. To send back a JSON payload, send back an HTML
// `<textarea>` element with a `data-type` attribute that contains the MIME
// type, and put the actual payload in the textarea:

//     <textarea data-type="application/json">
//       {"ok": true, "message": "Thanks so much"}
//     </textarea>

// The iframe transport plugin will detect this and attempt to apply the same
// conversions that jQuery applies to regular responses. That means for the
// example above you should get a Javascript object as the `data` parameter of
// the `complete` callback, with the properties `ok: true` and
// `message: "Thanks so much"`.

// ### Compatibility

// This plugin has primarily been tested on Safari 5, Firefox 4, and Internet
// Explorer all the way back to version 6. While I haven't found any issues with
// it so far, I'm fairly sure it still doesn't work around all the quirks in all
// different browsers. But the code is still pretty simple overall, so you
// should be able to fix it and contribute a patch :)

// ## Annotated Source

(function($, undefined) {

  // Register a prefilter that checks whether the `iframe` option is set, and
  // switches to the iframe transport if it is `true`.
  $.ajaxPrefilter(function(options, origOptions, jqXHR) {
    if (options.iframe) {
      return "iframe";
    }
  });

  // Register an iframe transport, independent of requested data type. It will
  // only activate when the "files" option has been set to a non-empty list of
  // enabled file inputs.
  $.ajaxTransport("iframe", function(options, origOptions, jqXHR) {
    var form = null,
        iframe = null,
        origAction = null,
        origTarget = null,
        origEnctype = null,
        addedFields = [],
        disabledFields = [],
        files = $(options.files).filter(":file:enabled");

    // This function gets called after a successful submission or an abortion
    // and should revert all changes made to the page to enable the
    // submission via this transport.
    function cleanUp() {
      $(addedFields).each(function() {
        this.remove();
      });
      $(disabledFields).each(function() {
        this.disabled = false;
      });
      form.attr("action", origAction || "")
          .attr("target", origTarget || "")
          .attr("enctype", origEnctype || "");
      iframe.attr("src", "javascript:false;").remove();
    }

    // Remove "iframe" from the data types list so that further processing is
    // based on the content type returned by the server, without attempting an
    // (unsupported) conversion from "iframe" to the actual type.
    options.dataTypes.shift();

    if (files.length) {
      // Determine the form the file fields belong to, and make sure they all
      // actually belong to the same form.
      files.each(function() {
        if (form !== null && this.form !== form) {
          jQuery.error("All file fields must belong to the same form");
        }
        form = this.form;
      });
      form = $(form);

      // Store the original form attributes that we'll be replacing temporarily.
      origAction = form.attr("action");
      origTarget = form.attr("target");
      origEnctype = form.attr("enctype");

      // We need to disable all other inputs in the form so that they don't get
      // included in the submitted data unexpectedly.
      form.find(":input:not(:submit)").each(function() {
        if (!this.disabled && (this.type != "file" || files.index(this) < 0)) {
          this.disabled = true;
          disabledFields.push(this);
        }
      });

      // If there is any additional data specified via the `data` option,
      // we add it as hidden fields to the form. This (currently) requires
      // the `processData` option to be set to false so that the data doesn't
      // get serialized to a string.
      if (typeof(options.data) === "string" && options.data.length > 0) {
        jQuery.error("data must not be serialized");
      }
      $.each(options.data || {}, function(name, value) {
        if ($.isPlainObject(value)) {
          name = value.name;
          value = value.value;
        }
        addedFields.push($("<input type='hidden'>").attr("name", name)
          .attr("value", value).appendTo(form));
      });

      // Add a hidden `X-Requested-With` field with the value `IFrame` to the
      // field, to help server-side code to determine that the upload happened
      // through this transport.
      addedFields.push($("<input type='hidden' name='X-Requested-With'>")
        .attr("value", "IFrame").appendTo(form));

      // Borrowed straight from the JQuery source
      // Provides a way of specifying the accepted data type similar to HTTP_ACCEPTS
      accepts = options.dataTypes[ 0 ] && options.accepts[ options.dataTypes[0] ] ?
        options.accepts[ options.dataTypes[0] ] + ( options.dataTypes[ 0 ] !== "*" ? ", */*; q=0.01" : "" ) :
        options.accepts[ "*" ]

      addedFields.push($("<input type='hidden' name='X-Http-Accept'>")
        .attr("value", accepts).appendTo(form));

      return {

        // The `send` function is called by jQuery when the request should be
        // sent.
        send: function(headers, completeCallback) {
          iframe = $("<iframe src='javascript:false;' name='iframe-" + $.now()
            + "' style='display:none'></iframe>");

          // The first load event gets fired after the iframe has been injected
          // into the DOM, and is used to prepare the actual submission.
          iframe.bind("load", function() {

            // The second load event gets fired when the response to the form
            // submission is received. The implementation detects whether the
            // actual payload is embedded in a `<textarea>` element, and
            // prepares the required conversions to be made in that case.
            iframe.unbind("load").bind("load", function() {

              var doc = this.contentWindow ? this.contentWindow.document :
                (this.contentDocument ? this.contentDocument : this.document),
                root = doc.documentElement ? doc.documentElement : doc.body,
                textarea = root.getElementsByTagName("textarea")[0],
                type = textarea ? textarea.getAttribute("data-type") : null;

              var status = textarea ? parseInt(textarea.getAttribute("response-code")) : 200,
                statusText = "OK",
                responses = { text: type ? textarea.value : root ? root.innerHTML : null },
                headers = "Content-Type: " + (type || "text/html")

              completeCallback(status, statusText, responses, headers);

              setTimeout(cleanUp, 50);
            });

            // Now that the load handler has been set up, reconfigure and
            // submit the form.
            form.attr("action", options.url)
              .attr("target", iframe.attr("name"))
              .attr("enctype", "multipart/form-data")
              .get(0).submit();
          });

          // After everything has been set up correctly, the iframe gets
          // injected into the DOM so that the submission can be initiated.
          iframe.insertAfter(form);
        },

        // The `abort` function is called by jQuery when the request should be
        // aborted.
        abort: function() {
          if (iframe !== null) {
            iframe.unbind("load").attr("src", "javascript:false;");
            cleanUp();
          }
        }

      };
    }
  });

})(jQuery);



(function($) {

  var remotipart;

  $.remotipart = remotipart = {

    setup: function(form) {
      form
        // Allow setup part of $.rails.handleRemote to setup remote settings before canceling default remote handler
        // This is required in order to change the remote settings using the form details
        .one('ajax:beforeSend.remotipart', function(e, xhr, settings){
          // Delete the beforeSend bindings, since we're about to re-submit via ajaxSubmit with the beforeSubmit
          // hook that was just setup and triggered via the default `$.rails.handleRemote`
          // delete settings.beforeSend;
          delete settings.beforeSend;

          settings.iframe      = true;
          settings.files       = $($.rails.fileInputSelector, form);
          settings.data        = form.serializeArray();
          settings.processData = false;

          // Modify some settings to integrate JS request with rails helpers and middleware
          if (settings.dataType === undefined) { settings.dataType = 'script *'; }
          settings.data.push({name: 'remotipart_submitted', value: true});

          // Allow remotipartSubmit to be cancelled if needed
          if ($.rails.fire(form, 'ajax:remotipartSubmit', [xhr, settings])) {
            // Second verse, same as the first
            $.rails.ajax(settings);
          }

          //Run cleanup
          remotipart.teardown(form);

          // Cancel the jQuery UJS request
          return false;
        })

        // Keep track that we just set this particular form with Remotipart bindings
        // Note: The `true` value will get over-written with the `settings.dataType` from the `ajax:beforeSend` handler
        .data('remotipartSubmitted', true);
    },

    teardown: function(form) {
      form
        .unbind('ajax:beforeSend.remotipart')
        .removeData('remotipartSubmitted')
    }
  };

  $('form').live('ajax:aborted:file', function(){
    var form = $(this);

    remotipart.setup(form);

    // If browser does not support submit bubbling, then this live-binding will be called before direct
    // bindings. Therefore, we should directly call any direct bindings before remotely submitting form.
    if (!$.support.submitBubbles && $().jquery < '1.7' && $.rails.callFormSubmitBindings(form) === false) return $.rails.stopEverything(e);

    // Manually call jquery-ujs remote call so that it can setup form and settings as usual,
    // and trigger the `ajax:beforeSend` callback to which remotipart binds functionality.
    $.rails.handleRemote(form);
    return false;
  });

})(jQuery);
(function() {

  window.homeObject = {
    setup: function() {}
  };

  $(".admin_search #update_team").live("keyup", function(e) {
    var label;
    label = $(this).val() + " " + $(".admin_search #update_mascot").val();
    $(".admin_search .team_name label").html(label);
    return $(".admin_search #team_name").val(label);
  });

  $(".admin_search #update_mascot").live("keyup", function(e) {
    var label;
    label = $(".admin_search #update_team").val() + " " + $(this).val();
    $(".admin_search .team_name label").html(label);
    return $(".admin_search #team_name ").val(label);
  });

  $(".admin_search #admin_new_team #team_school_attributes_name").live("keyup", function(e) {
    var label;
    if ($(".admin_search #admin_new_team #team_mascot").val() === "") {
      label = $(this).val();
      $(".admin_search #admin_new_team #showteamname").html(label);
      return $(".admin_search #admin_new_team .name_hidden").val(label);
    } else {
      label = $(this).val() + " " + $(".admin_search #team_mascot").val();
      $(".admin_search #admin_new_team #showteamname").html(label);
      return $(".admin_search #admin_new_team .name_hidden").val(label);
    }
  });

  $(".admin_search #admin_new_team #team_mascot").live("keyup", function(e) {
    var label;
    if ($(".admin_search #admin_new_team #team_school_attributes_name").val === "") {
      label = $(this).val();
      $(".admin_search #admin_new_team #showteamname").html(label);
      return $(".admin_search #admin_new_team .name_hidden").val(label);
    } else {
      label = $(".admin_search #admin_new_team #team_school_attributes_name").val() + " " + $(this).val();
      $(".admin_search #admin_new_team #showteamname").html(label);
      return $(".admin_search #admin_new_team .name_hidden").val(label);
    }
  });

  $(".admin_search #admin_new_team .clickonshow").live("click", function(e) {
    $("#new_team")[0].reset();
    return $(".admin_search #admin_new_team #showteamname").html("");
  });

  $("#conference_state_id").live("change", function(e) {
    var conf_id, options, state;
    conf_id = $("#team_school_attributes_conference_id");
    options = "<option value=''>Select one</option>";
    $("#team_school_attributes_conference_id option").remove();
    state = $(this).attr("value");
    if (state === "") {
      return conf_id.append(options);
    } else {
      return $.ajax({
        type: "GET",
        url: "teams/get_conferences",
        data: {
          state_id: state
        },
        success: function(data) {
          var i;
          i = 0;
          while (i < data.length) {
            options += "<option value=" + data[i]["id"] + ">" + data[i]["name"] + "</option>";
            i++;
          }
          conf_id.append(options);
        },
        error: function(data) {
          return alert("There are something went wrong");
        }
      });
    }
  });

  $("#admin_edit_team .team_id .link_edit").live('click', function(e) {
    return $.ajax({
      type: "GET",
      url: $(this).data("url"),
      success: function(data) {
        return $("#edit_admin").html(data);
      },
      error: function(data) {}
    });
  });

  $(".admin_search #state_id_admin").change(function(e) {
    return $.ajax({
      type: "GET",
      url: "teams/search",
      data: {
        state_id: $("#state_id_admin").attr("value")
      },
      success: function(data) {
        $("#conference_admin").html(data);
        return $("#conference_admin").show;
      },
      error: function(data) {
        $("#conference_admin").html(data);
        return $("#conference_admin").show;
      }
    });
  });

  $(".admin_search .New_team").live("click", function(e) {
    var form;
    $(".admin_search .loading_admin").removeClass("none_admin");
    $(".admin_search .team_admin.none_admin").hide();
    form = $(".admin_search form");
    return $.ajax({
      type: "GET",
      url: form.attr("action"),
      data: form.serialize(),
      dataType: "script",
      success: function(data) {
        return $(".admin_search .loading_admin").addClass("none_admin");
      },
      error: function(data) {
        $(".admin_search .loading_admin").addClass("none_admin");
        return $(".admin_search .team_admin").show();
      }
    });
  });

  $(".delete_button").click(function(e) {
    var button_id, email_id, email_text, r, row_id, team_id, temp_string;
    r = confirm("Do you want to delete this manager");
    if (r) {
      temp_string = $(this).attr("id");
      button_id = temp_string.substring(6, temp_string.length);
      row_id = "#team_manager" + button_id;
      email_id = "#manageremail" + button_id;
      team_id = $("#team" + button_id).val();
      email_text = $(email_id).attr("placeholder");
      $(row_id).remove();
      return $.ajax({
        type: "get",
        url: "/admin/users/delete_by_email",
        data: {
          email: email_text,
          team: team_id
        },
        success: function(data) {},
        error: function(data) {}
      });
    }
  });

  $(".change_button").click(function(e) {
    var button_id, email_id, new_email_text, old_email_text, r, row_id, team_id, temp_string;
    r = confirm("Do you want to change this manager?");
    if (r) {
      temp_string = $(this).attr("id");
      button_id = temp_string.substring(6, temp_string.length);
      row_id = "#team_manager" + button_id;
      email_id = "#manageremail" + button_id;
      team_id = $("#team" + button_id).val();
      old_email_text = $(email_id).attr("placeholder");
      new_email_text = $(email_id).val();
      if (new_email_text.match(/[\w|-|_|.|\d]+\@\w+\.\w+/)) {
        if (new_email_text !== old_email_text) {
          return $.ajax({
            type: "get",
            url: "/admin/users/change_manager_by_email",
            dataType: "json",
            data: {
              old_email: old_email_text,
              new_email: new_email_text,
              team: team_id
            },
            success: function(data) {
              if (data["result"]) {
                alert("Change manager successfully");
                $(email_id).attr("value", "");
                return $(email_id).attr("placeholder", new_email_text);
              } else {
                alert("Unsuccessfully change the manager");
                return $(email_id).attr("value", "");
              }
            },
            error: function(data) {
              return alert("error");
            }
          });
        } else {
          alert("Nothing change");
          return $(email_id).attr("value", "");
        }
      } else {
        alert("Invalid email input");
        return $(email_id).attr("value", "");
      }
    }
  });

}).call(this);
/*

  Author - Rudolf Naprstek
  Website - http://www.thimbleopensource.com/tutorials-snippets/jquery-plugin-filter-text-input
  Version - 1.3.0
  Release - 28th January 2012

  Thanks to Niko Halink from ARGH!media for bugfix!
 
  Remy Blom: Added a callback function when the filter surpresses a keypress in order to give user feedback

*/


(function($){  
  
    $.fn.extend({   

        filter_input: function(options) {  

          var defaults = {  
              regex:".*",
              live:false
          }  
                
          var options =  $.extend(defaults, options);  
          var regex = new RegExp(options.regex);
          
          function filter_input_function(event) {

            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;

            // 8 = backspace, 9 = tab, 13 = enter, 35 = end, 36 = home, 37 = left, 39 = right, 46 = delete
            if (key == 8 || key == 9 || key == 13 || key == 35 || key == 36|| key == 37 || key == 39 || key == 46) {

              if ($.browser.mozilla) {

                // if charCode = key & keyCode = 0
                // 35 = #, 36 = $, 37 = %, 39 = ', 46 = .
         
                if (event.charCode == 0 && event.keyCode == key) {
                  return true;                                             
                }

              }
            }


            var string = String.fromCharCode(key);
            if (regex.test(string)) {
              return true;
            } else if (typeof(options.feedback) == 'function') {
       	      options.feedback.call(this, string);	
            }
            return false;
          }
          
          if (options.live) {
            $(this).live('keypress', filter_input_function); 
          } else {
            return this.each(function() {  
              var input = $(this);
              input.unbind('keypress').keypress(filter_input_function);
            });  
          }
          
        }  
    });  
      
})(jQuery); 
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//




jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
;
