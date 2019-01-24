_.set(window, "clara.js_define", function(object_name, actual_object) {


  // define a JS object
  // by default will trigger only on the right page if object_name follow Rails conventions
  _.set(window, "clara." + object_name, {
    trigger_function: function() {
      return $.currentAppPath() === object_name + "_path";
    },
    main_function: _.noop
  });

  // take all functions, trigger_function can also be overriden this way
  _.assign(clara[object_name], actual_object);

  clara.js_valve(
    clara[object_name],
    object_name
  );

});



