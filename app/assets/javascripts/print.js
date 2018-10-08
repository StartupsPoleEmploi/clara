load_js_for_page([], function(){
  
  $('.c-breadcrumb-printer__item').click(function(e) {
    if (typeof ga === "function") {
      ga('send', 'event', 'results', 'print', document.location.pathname);
    }
    if (_.get(window, 'main_store')) {
      window.main_store.dispatch({type:'FOLD_ELIGY', eligy_name: "eligibles"});
      window.main_store.dispatch({type:'FOLD_ELIGY', eligy_name: "ineligibles"});
      window.main_store.dispatch({type:'FOLD_ELIGY', eligy_name: "uncertains"});      
    }
    window.print();
  });
  
});
