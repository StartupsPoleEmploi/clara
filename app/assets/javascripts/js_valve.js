/**
*
* Avoid to force the actual JS file to be included.
*
* Useful for tests.
*
*/

_.set(window, "clara.js_valve", function (cond_f, actual_f, optional_id) {
  return _.defaultTo(
            _.get(window, 'clara.js_fire'),
            _.noop
          )(cond_f, actual_f, optional_id);
});


