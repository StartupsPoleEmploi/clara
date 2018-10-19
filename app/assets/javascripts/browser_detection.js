$( document ).ready(function() {

  var template_to_add = 
  "<div class='c-browser-deprecated u-padding' style='background-color: orange;'>" +
    "<div class='c-browser-deprecated__line'>" +
      "⚠ Certains contenus ne seront pas correctement affichés car votre navigateur est obsolète." +
    "</div>" +
    "<div class='c-browser-deprecated__line'>" +
      "<a href='https://whatbrowser.org'>Ce site</a> peut vous aider à mettre à jour votre navigateur." +
    "</div>" +
  "</div>";

  

  // DEBUG ONLY
  // $('.c-magic-number').text($(".c-magic-number").text() + " " + window._DD);

  // See https://github.com/ergcode/ergonomic.detect_flex#manual
  // console.log("checking flexbox depreciation");
  if (window._DD !== 1) {
    if($('.c-browser-deprecated').length === 0) $('body').prepend(template_to_add);
  }
}, "global_browser_detection");

