function load_js_per_page(condition_function, appliable_function, optional_id) {

  $( document ).ready(function() {
    if (condition_function()) {
      appliable_function();
    }
  });

};

