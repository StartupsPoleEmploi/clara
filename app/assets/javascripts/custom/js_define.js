_.set(window, "clara.js_define", function(object_name, actual_object) {

  function get_obj_path() {
    return "clara." + object_name;
  }

  function get_obj() {
    return _.get(window, get_obj_path());
  }


  // define a JS object
  // by default will trigger only on the right page if object_name follow Rails conventions
  _.set(window, get_obj_path(), {
    trigger_function: function() {
      return $.currentAppPath() === object_name + "_path";
    },
    main_function: _.noop
  });

  // take all functions, trigger_function can also be overriden this way
  _.assign(get_obj(), actual_object);

  clara.js_valve(
    get_obj(),
    object_name
  );

});



