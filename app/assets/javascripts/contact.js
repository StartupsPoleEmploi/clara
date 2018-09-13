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


$(document).on('ready turbolinks:load', function () {
  if ($( 'body' ).hasClass('contact', 'index' )) {
    clara.init_contact();
  }
});
