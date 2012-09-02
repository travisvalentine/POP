var myAccountPanel = $('#my-account');
var myAccountPanelTop = 24;

$('#new-badge').delegate('#my-account-handle', 'click', function(e) {
  myAccountPanel = $('#my-account');
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