$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('aides', 'index')) {

    clara.accordeon_component('.c-result-list--eligible', false);
    clara.accordeon_component('.c-result-list--uncertain', true);
    clara.accordeon_component('.c-result-list--ineligible', true);
    
  }
});
