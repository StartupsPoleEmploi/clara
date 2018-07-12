$(document).on('ready turbolinks:load', function () {

  $('.c-breadcrumb-printer__item').click(function(e) {
    if (typeof ga === "function") {
      ga('send', 'event', 'results', 'print', document.location.pathname);
    }
    window.main_store.dispatch({type:'FOLD_ELIGY', eligy_name: "eligibles"});
    window.main_store.dispatch({type:'FOLD_ELIGY', eligy_name: "ineligibles"});
    window.main_store.dispatch({type:'FOLD_ELIGY', eligy_name: "uncertains"});
    window.print();
  });

});
