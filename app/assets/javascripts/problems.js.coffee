$ ->
  $(".chzn-container").chosen
  $(".chzn-select").chosen disable_search_threshold: 25

  $("#problem_body").charCount
    allowed: 250
    warning: 20
    counterText: " characters remaining"

  $("#problem_solution_body").charCount
    allowed: 250
    warning: 20
    counterText: " characters remaining"

  $("#solution_body").charCount
    allowed: 250
    warning: 20
    counterText: " characters remaining"

  charCounter = $("span.counter")
  charCounter.toggle()

  $('#candidates').toggle()

  $("textarea#problem_body").focus()

  $("input#tweet").change ->
    if $('input').is(':checked')
      $('#candidates').toggle()
    else
      $('#candidates').toggle()

  $("input#tweet_bo").change ->
    if $("input#tweet_bo").is(':checked')
      $("input#tweet_mr").attr('disabled', true)
    else
      $("input#tweet_mr").attr('disabled', false)

  $("input#tweet_mr").change ->
    if $("input#tweet_mr").is(':checked')
      $("input#tweet_bo").attr('disabled', true)
    else
      $("input#tweet_bo").attr('disabled', false)

  # $("textarea#problem_body").next().toggle()

  # $("textarea#problem_body").focus ->
  #   $(this).parent().find('.counter').toggle()

  # $("textarea#problem_body").focusout ->
  #   $(this).parent().find('.counter').toggle()

  # $("textarea#problem_solution_body").focus ->
  #   $(this).parent().find('.counter').toggle()
  #   $(this).css "padding-bottom", "+=5"
  #   $(this).css "margin-bottom", "+=10"

  # $("textarea#problem_solution_body").focusout ->
  #   $(this).parent().find('.counter').toggle()
  #   $(this).css "padding-bottom", "-=0"
  #   $(this).css "margin-bottom", "-=5"

  # $("textarea#problem_solution_body").mouseout ->
  #   if $(this).is(':focus')
  #     $(this).blur()
  #     $(this).parent().next().hide()