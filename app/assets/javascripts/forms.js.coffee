$ ->
  $("body").addClass "inaug"
  $(".form-container").toggle()
  $("#email_signup").click ->
    $(this).parent().parent().animate
      marginTop: "20px"
      height: "437px"
    , 300
    $(".form-container").toggle()
    $("input#user_profile_attributes_name").focus()
    $("#actions").toggle()