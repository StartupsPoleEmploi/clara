_.set(
  window, 
  'clara.init_contact', 
  _.throttle(function() {
      var f_remove_errors = function(){
        var $elt = $(this);
        $elt.closest('.c-contact-field').find('.c-contact-validation').hide();
        $elt.closest('.c-contact-field').find('.is-error').removeClass('is-error');
      };
      $('.c-contact-input').on('input', f_remove_errors);
      $('.c-contact-input-select').on('change', f_remove_errors);
    }, 
    1000)
);

clara.load_js(function only_if(){return $("body").hasClasses("contact", "index")}, function() {

  clara.init_contact();
  var $to_be_focused = $("body");
  if ($('.is-error').length === 0) {
    $to_be_focused = $("#first_name");
  } else {
    $to_be_focused = $(".is-error")[0];
    if ($($to_be_focused).attr('id') === 'askfor') {
      $to_be_focused = $("#contact_form_askfor_signaler");
    }
    if ($($to_be_focused).attr('id') === 'youare') {
      $to_be_focused = $("#contact_form_youare_particulier");
    }
  }
  $to_be_focused.focus();
    
});
