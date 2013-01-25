CARDNUM_VALIDATOR = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/
CVV = /^\d*$/
window.CARD_TYPE_VALIDATORS = [
  { value: 'USA_express', reg: /^3[47][0-9]{13}$/ },
  { value: 'discover', reg: /^6(?:011|5[0-9]{2})[0-9]{12}$/ },
  { value: 'visa', reg: /^4[0-9]{12}(?:[0-9]{3})?$/ },
  { value: 'jcb', reg: /^(?:2131|1800|35\d{3})\d{11}$/ },
  { value: 'dinners_club', reg: /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/ },
  { value: 'master_card', reg: /^5[1-5][0-9]{14}$/ }
]

$('#choose_popup').modal({
  backdrop: "static"
})

$(".btn_ok").live "click", () ->
  location.reload()
  return

$(".icon-credit-card").live "click", () ->
  $(".icon-credit-card").removeClass("selected")
  $(this).addClass("selected")
  id_name = $(this).parent().attr("for")
  radio = $("#"+id_name).attr("checked", "checked")
  return


$("#btn_payment").live "click", () ->
  if $('#term_of_use').attr('checked') == "checked" || $("#term_of_use").val() == "true"
    $("#btn_payment").attr("disabled", "disabled")
    $("#warning-term").html("")
    $("#payment_form").submit()
  else
    $("#warning-term").html("Please accept the Team of use.")
    return false
  return

$("#agree_payment").live "click", () ->
  $("#payment_options").modal('hide');
  $("#options-form").submit()
  return
$('#cvv-popup').live "hover", () ->
  $('#cvv-popup').popover
    title: null
    html: 'true'
    content: '<img src="/assets/cvv.png" alt="Cvv">'
    trigger: 'hover'

$("#options").live "click", () ->
  if $("#options input[type='radio']:checked").val() == "false"
    $("#introduce-monthly").show()
    $("#introduce-individual").hide()
  else
    $("#introduce-individual").show()
    $("#introduce-monthly").hide()
  return
$("#choose_option").click ->
  option_value = $('#choose input[type=radio]:checked').val()
  if option_value == "monthly"
    $('#choose_popup').modal('hide')
  else if option_value == "individual"
    window.location.href = "term_and_service"
  return


$('#order_card_number').change ->
  card_type = $("#payment_card").find("input:checked")
  if card_type.length == 0
    $("#type_error").html('Please choose card type!')
  else
    for validator in CARD_TYPE_VALIDATORS
      if validator.value == card_type
        if !validator.reg.test($(this).val())
          $("#card_error").html('Your card number does not match this card_type!')
        else
          $("#card_error").html("")
          $("#type_error").html("")
  return

$("#payment_card").find("input").live "click", () ->
  card_num = $('#order_card_number').val()
  console.log $(this).val()
  console.log card_num
  for validator in CARD_TYPE_VALIDATORS
    if validator.value == $(this).val()
      if card_num!='' && !validator.reg.test(card_num)
        $("#card_error").html('Your card number does not match this card_type!')
      else
        $("#card_error").html("")
  return


$("#order_card_verification").blur ->
  cvv = $("#order_card_verification").val()
  if !CVV.test(cvv)
    $("#cvv_error").html('Your card verification value is invalid!')
  else
    $("#cvv_error").html("")
  return

$("#request_payment").click ->
  $("#check_login").modal("hide")
  return

$("#post_select_team_id").change ->
  $.ajax
    type: "GET"
    url: "/show_sport"
    data: {sport: $(this).attr("value"), team_id: $("#current_team_id").val()}
    success: (data)->
      $(".ajax-loading").addClass "hidden"
      $("#schedule-data-table").html(data)
      return
    error: (errors, status)->
      $(".ajax-loading").addClass "hidden"
      return
$("#close_payment").click ->
  $("#type_error").html("")
  $("#card_error").html("")
  $("#cvv_error").html("")
  $("#firstname_error").html("")
  $("#lastname_error").html("")
  $("#address_error").html("")
  $("#city_error").html("")
  $("#zip_code_error").html("")
  return


