$(document).on('ready turbolinks:load', function () {

  $('.c-breadcrumb-printer__item').click(function(e) {
    if (typeof ga === "function") {
      ga('send', 'event', 'results', 'print', document.location.pathname);
    }
    window.print();
  });

});
