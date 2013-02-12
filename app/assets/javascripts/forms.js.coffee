$ ->
  $(".form-container").toggle()
  $("#email_signup").click ->
    $(this).parent().parent().animate
      marginTop: "20px"
      height: "437px"
    , 300
    $("#address label.message").text("Optional. We will not share.")
    $("#birthday_selects label.message").text("Birthday can't be blank")
    $("#form_header h1").css 'line-height', '40px'
    $(".form-container").toggle()
    $("input#user_profile_attributes_name").focus()
    $("#actions").toggle()