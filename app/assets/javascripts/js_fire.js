_.set(window,'clara.js_fire',

  function (condition_function, appliable_function, optional_id) {

    $( document ).ready(function() {
      if (condition_function()) {
        console.debug("loaded JS " + optional_id);
        appliable_function();
      }
    });

  }

);

