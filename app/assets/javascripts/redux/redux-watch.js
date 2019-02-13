// freely inspired from https://github.com/jprichardson/redux-watch/blob/master/index.js
Redux.watch = 

  (function(){

    function getValue (context, path) {
      if (path.indexOf('.') == -1 && path.indexOf('[') == -1) {
        return context[path];
      }

      var crumbs = path.split(/\.|\[|\]/g);
      var i = -1;
      var len = crumbs.length;
      var result;

      while (++i < len) {
        if (i == 0) result = context;
        if (!crumbs[i]) continue;
        if (result == undefined) break;
        result = result[crumbs[i]];
      }

      return result;
    }

    function defaultCompare (a, b) {
      return a === b
    }

    function watch (getState, objectPath, compare) {
      compare = compare || defaultCompare
      var currentValue = getValue(getState(), objectPath)
      return function w (fn) {
        return function () {
          var newValue = getValue(getState(), objectPath)
          if (!compare(currentValue, newValue)) {
            var stateCopy = JSON.parse(JSON.stringify(getState()))
            var oldValue = currentValue
            currentValue = newValue
            fn(newValue, oldValue, objectPath, stateCopy)
          }
        }
      }
    }

    return watch;

  })();
