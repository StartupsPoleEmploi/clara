$(document).on('ready turbolinks:load', function() {

  $('.c-radiolist__element').keypress(function(e){
    if((e.keyCode ? e.keyCode : e.which) == 13){
      $($(this).find('input')).trigger('click');
    }
  });
    
});
