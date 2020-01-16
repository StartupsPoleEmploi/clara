// This is a hack to hide action button from detail page
// Thus preventing to modify/delete an association in administrate

$( document ).ready(function() {
  if (_.startsWith($('.main-content__header a.button').text(), "Modifier")) {
    // We're inside a detail page. Very hacky, indeed.

    // remove "modify" link
    $('a.action-edit').remove();
    // remove "suppress" link
    $('a.text-color-red').remove();

  }
});
