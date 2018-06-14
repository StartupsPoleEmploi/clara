$( document ).ready(function() {

  $('.c-breadcrumb-print').click(function(e) {
    if (typeof ga === "function") {
      ga('send', 'event', 'results', 'print', document.location.pathname);
    }
    window.print();
  });

});
