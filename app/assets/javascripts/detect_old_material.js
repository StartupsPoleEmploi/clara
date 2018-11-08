/* 
 * forked and amended from https://raw.githubusercontent.com/ergcode/ergonomic.detect_flex/master/detect_flex-2009.js
 * !!WARNING : This script is manually minified and inserted at the very bottom of application.html.haml
 * Do not insert into application.js, because with old device, first bugs prevents this script to execute correctly
 */


(function () {

  var template_to_add = 
  "<div class='c-browser-deprecated u-padding' style='background-color: orange;'>" +
    "<div class='c-browser-deprecated__line'>" +
      "⚠ Certains contenus ne seront pas correctement affichés car votre navigateur est obsolète." +
    "</div>" +
    "<div class='c-browser-deprecated__line'>" +
      "<a href='https://whatbrowser.org'>Ce site</a> peut vous aider à mettre à jour votre navigateur." +
    "</div>" +
  "</div>";

  window._DD;

  var documentLink = document,
    getComputedStyleLink = window.getComputedStyle,
    documentHeadLink = documentLink.getElementsByTagName('head')[0],
    elementForTesting = documentLink.createElement('p'),
    elementForTestingStyle = elementForTesting.style,
    display = 'display',
    displayVariant = [
      'flex',         // 1
      '-webkit-flex', // 2
      '-ms-flexbox',  // 3
      '-webkit-box',  // 4
      '-moz-box'      // 5
    ],
    abilityFlexWrap = [
      'flexWrap',
      'WebkitFlexWrap',
      'msFlexWrap'
    ];


  documentHeadLink.appendChild(elementForTesting);


  for (var i = 0, len = displayVariant.length; i < len; i++) {
    if (abilityFlexWrap[i] && !(abilityFlexWrap[i] in elementForTestingStyle)) continue;

    elementForTestingStyle.cssText = display + ':' + displayVariant[i];
    var getDisplayStyle = 
      (getComputedStyleLink)  ? getComputedStyleLink(elementForTesting, null).getPropertyValue(display) :
                                elementForTesting.currentStyle[display];

    if (getDisplayStyle == displayVariant[i]) {
      _DD = i + 1;
      break;
    }
  }


  documentHeadLink.removeChild(elementForTesting);

  if (window._DD !== 1) {

    var content_to_add = document.createElement("div");
    content_to_add.id = "content_to_add";
    content_to_add.innerHTML = template_to_add;

    document.body.insertBefore(content_to_add, document.body.childNodes[0]);
  }


})();


