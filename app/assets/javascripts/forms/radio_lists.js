clara.load_js(function only_if(){return true}, function() {

  $('.js-enterspace').keypress(function(e){
    var theCode = (e.keyCode ? e.keyCode : e.which);
    if(theCode === 13 || theCode === 32){
      $($(this).find('input')).trigger('click');
    }
  });    
  
}, "global_radio_list");
