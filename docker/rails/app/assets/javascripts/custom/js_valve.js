/**
*
* Avoid to force the actual JS file to be included.
*
* Useful for tests.
*
*/

_.set(window, "clara.js_valve", function (obj, optional_id) {
  return _.defaultTo(
            _.get(window, 'clara.js_fire'),
            _.noop
          )(obj, optional_id);
});


