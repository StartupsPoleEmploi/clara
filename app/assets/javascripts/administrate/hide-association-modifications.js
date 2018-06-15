// This is a hack to hide action button from detail page
// Thus preventing to modify/delete an association in administrate

$( document ).ready(function() {
  // See https://stackoverflow.com/a/40725409/2595513
  var lastPartOfUrl = window.location.pathname.split("/").pop();
  if (_.isNumeric(lastPartOfUrl)) {
    // We're inside a detail page. Very hacky, indeed.

    // remove "modify" link
    $('a.action-edit').remove();
    // remove "suppress" link
    $('a.text-color-red').remove();

  }
});
