function load_js_per_page(condition_function, appliable_function, optional_id) {

  $( document ).ready(function() {
    console.log("ready---");
    if (condition_function()) {
      console.log("condition_function---");
      appliable_function();
    }
  });

};

