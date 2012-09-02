var myAccountPanel = $('.dropdown-toggle');
var myAccountPanelTop = 24;

$('#new-badge').delegate('#user_settings', 'click', function(e) {
  myAccountPanel = $('.dropdown-toggle');
  e.preventDefault();
  e.stopPropagation();

  $(this).closest('li').toggleClass('active');
  if (myAccountPanel.is(':visible')) {
    myAccountPanel.hide();
  } else {
    myAccountPanel.
      css({top: (myAccountPanelTop - 10 +'px'), opacity: 0.0}).
      show().
      animate({top: (myAccountPanelTop + 'px'), opacity: 1.0}, {duration: 200});
  }
});