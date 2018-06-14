$(document).on('ready', function() {

  $('.c-radiolist__element').keypress(function(e){
    var theCode = (e.keyCode ? e.keyCode : e.which);
    if(theCode === 13 || theCode === 32){
      $($(this).find('input')).trigger('click');
    }
  });
    
});
