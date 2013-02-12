$ ->
  $("input#user_profile_attributes_name").next(".field_with_errors").children("label.message").text("can't be blank")
  $("input#user_profile_attributes_name").keyup ->
    if $(this).val() == ""
      $(this).next(".field_with_errors").children("label.message").show()
    else
      $(this).next(".field_with_errors").children("label.message").hide()

  checkBirthdaySelects = ->
    month_empty = $("#user_profile_attributes_birthday_2i").val() is ""
    day_empty   = $("#user_profile_attributes_birthday_3i").val() is ""
    year_empty  = $("#user_profile_attributes_birthday_1i").val() is ""
    if month_empty or day_empty or year_empty
      $("#birthday_selects label.message").show()
      $("#birthday_selects label.message").text("Birthday can't be blank")
    else
      $("#birthday_selects label.message").hide()

  $("#birthday_selects label.message").hide()

  $("form.new_user #birthday_selects select").live "change", checkBirthdaySelects

  $("form.new_user input[type='submit']").click (event) ->
    month_empty = $("#user_profile_attributes_birthday_2i").val() is ""
    day_empty   = $("#user_profile_attributes_birthday_3i").val() is ""
    year_empty  = $("#user_profile_attributes_birthday_1i").val() is ""
    if month_empty or day_empty or year_empty
      $("#birthday_selects label.message").show()
      $("#birthday_selects label.message").text("Birthday can't be blank")
      event.preventDefault()
    else
      $("#birthday_selects label.message").hide()