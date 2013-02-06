
CARDNUM_VALIDATOR = undefined
CVV = undefined
CARDNUM_VALIDATOR = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/
CVV = /^\d*$/
window.CARD_TYPE_VALIDATORS = [
  value: "USA_express"
  reg: /^3[47][0-9]{13}$/
,
  value: "discover"
  reg: /^6(?:011|5[0-9]{2})[0-9]{12}$/
,
  value: "visa"
  reg: /^4[0-9]{12}(?:[0-9]{3})?$/
,
  value: "jcb"
  reg: /^(?:2131|1800|35\d{3})\d{11}$/
,
  value: "dinners_club"
  reg: /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/
,
  value: "master_card"
  reg: /^5[1-5][0-9]{14}$/
]
$("#choose_popup").modal backdrop: "static"
$(".btn_ok").bind "click", ->
  location.reload()


# $('#pui-tabs a').delegate('.tab-close', 'click', function(e) { 
$(".icon-credit-card").bind "click", ->
  id_name = undefined
  radio = undefined
  $(".icon-credit-card").removeClass "selected"
  $(this).addClass "selected"
  id_name = $(this).parent().attr("for")
  radio = $("#" + id_name).attr("checked", "checked")

$("#btn_payment").bind "click", ->
  if $("#term_of_use").attr("checked") is "checked" or $("#term_of_use").val() is "true"
    $("#btn_payment").attr "disabled", "disabled"
    $("#warning-term").html ""
    $("#payment_form").submit()
  else
    $("#warning-term").html "Please accept the Team of use."
    false

$("#agree_payment").bind "click", ->
  $("#payment_options").modal "hide"
  $("#options-form").submit()

$("#cvv-popup").bind "hover", ->
  $("#cvv-popup").popover
    title: null
    html: "true"
    content: "<img src=\"/assets/cvv.png\" alt=\"Cvv\">"
    trigger: "hover"


$("#options").bind "click", ->
  if $("#options input[type='radio']:checked").val() is "false"
    $("#introduce-monthly").show()
    $("#introduce-individual").hide()
  else
    $("#introduce-individual").show()
    $("#introduce-monthly").hide()

$("#choose_option").click ->
  option_value = undefined
  option_value = $("#choose input[type=radio]:checked").val()
  if option_value is "monthly"
    $("#choose_popup").modal "hide"
  else window.location.href = "term_and_service"  if option_value is "individual"

$("#order_card_number").change ->
  card_type = undefined
  validator = undefined
  _i = undefined
  _len = undefined
  card_type = $("#payment_card").find("input:checked")
  if card_type.length is 0
    $("#type_error").html "Please choose card type!"
  else
    _i = 0
    _len = CARD_TYPE_VALIDATORS.length

    while _i < _len
      validator = CARD_TYPE_VALIDATORS[_i]
      if validator.value is card_type
        unless validator.reg.test($(this).val())
          $("#card_error").html "Your card number does not match this card_type!"
        else
          $("#card_error").html ""
          $("#type_error").html ""
      _i++

$("#payment_card").find("input").bind "click", ->
  card_num = undefined
  validator = undefined
  _i = undefined
  _len = undefined
  card_num = $("#order_card_number").val()
  console.log $(this).val()
  console.log card_num
  _i = 0
  _len = CARD_TYPE_VALIDATORS.length

  while _i < _len
    validator = CARD_TYPE_VALIDATORS[_i]
    if validator.value is $(this).val()
      if card_num isnt "" and not validator.reg.test(card_num)
        $("#card_error").html "Your card number does not match this card_type!"
      else
        $("#card_error").html ""
    _i++

$("#order_card_verification").blur ->
  cvv = undefined
  cvv = $("#order_card_verification").val()
  unless CVV.test(cvv)
    $("#cvv_error").html "Your card verification value is invalid!"
  else
    $("#cvv_error").html ""

$("#request_payment").click ->
  $("#check_login").modal "hide"

$("#post_select_team_id").change ->
  $.ajax
    type: "GET"
    url: "/show_sport"
    data:
      sport: $(this).attr("value")
      team_id: $("#current_team_id").val()

    success: (data) ->
      $(".ajax-loading").addClass "hidden"
      $("#schedule-data-table").html data

    error: (errors, status) ->
      $(".ajax-loading").addClass "hidden"


$("#close_payment").click ->
  $("#type_error").html ""
  $("#card_error").html ""
  $("#cvv_error").html ""
  $("#firstname_error").html ""
  $("#lastname_error").html ""
  $("#address_error").html ""
  $("#city_error").html ""
  $("#zip_code_error").html ""

