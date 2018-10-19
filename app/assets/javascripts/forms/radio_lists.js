load_js_for_page([], function(){

  $('.js-enterspace').keypress(function(e){
    var theCode = (e.keyCode ? e.keyCode : e.which);
    if(theCode === 13 || theCode === 32){
      $($(this).find('input')).trigger('click');
    }
  });    
  
}, "radio_list");
