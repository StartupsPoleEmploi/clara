$(document).on('ready turbolinks:load', function() {
  if ($( '#table-rule-check' ).length) {
    $("tr[data-link]").click(function() {
      window.location = $(this).data("link");
    });
  }
});
