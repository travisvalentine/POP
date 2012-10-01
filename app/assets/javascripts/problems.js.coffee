$ ->
  $(".chzn-select").chosen disable_search_threshold: 25
  $("#problem_body").charCount
    allowed: 250
    warning: 20
    counterText: " characters remaining"

  $("#problem_solution_body").charCount
    allowed: 250
    warning: 20
    counterText: " characters remaining"

  charCounter = $("span.counter")
  charCounter.toggle()
  $("textarea#problem_body, textarea#problem_solution_body").focus ->
    $(this).next().toggle()

  $("textarea#problem_solution_body").focus ->
    $(this).css "padding-bottom", "+=5"
    $(this).css "margin-bottom", "+=10"

  $("textarea#problem_solution_body").focusout ->
    $(this).css "padding-bottom", "-=5"
    $(this).css "margin-bottom", "-=10"

  $("textarea#problem_body, textarea#problem_solution_body").focusout ->
    $(this).next().toggle()

