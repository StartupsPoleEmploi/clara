$(document).on('ready turbolinks:load', function() {
  if ($('body').hasClass('aides', 'index')) {

    /*  Javascript */
//Paramètres (composant_config.js)
var acsa_config = {
  checkbox : {
    //CSS
    checkbox : 'acsa-checkbox',
    stateFalse : 'acsa-checkbox-false',
    stateTrue : 'acsa-checkbox-true'
  }  
}
/* Initialisation */
  var listCheckbox = document.getElementsByClassName( acsa_config.checkbox.checkbox );
  var checkbox = new Array();
  for ( var i = 0, len = listCheckbox.length; i < len; i++ ){
    listCheckbox[i].addEventListener( 'keydown', function setListChekbox( event ){
      var key = event.keyCode;
      checkbox[i] = new Checkbox ( this, key, event );
    }, false );
    listCheckbox[i].addEventListener( 'click', function setListChekbox(){
      var key = 32;
      checkbox[i] = new Checkbox ( this, key );
    }, false );
  }

    // clara.accordeon_component('.c-result-list--eligible', false);
    // clara.accordeon_component('.c-result-list--uncertain', false);
    // clara.accordeon_component('.c-result-list--ineligible', true);
    
  }
});
