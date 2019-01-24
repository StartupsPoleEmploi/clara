_.set(window,'clara.js_fire',

  function (obj, optional_id) {

    $( document ).ready(function() {
      if (obj.trigger_function()) {
        console.debug("loaded JS " + optional_id);
        obj.main_function();
      }
    });

  }

);

