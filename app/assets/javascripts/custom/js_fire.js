_.set(window,'clara.js_fire',

  function (obj, optional_id) {

    $( document ).ready(function() {
      if (obj.please_if()) {
        console.debug("loaded JS " + optional_id);
        obj.please();
      }
    });

  }

);

