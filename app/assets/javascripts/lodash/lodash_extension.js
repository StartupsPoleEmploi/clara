_.mixin({

  // 'sometext-20202-303', '-' => '20202-303'
  textAfter: function(str, prefix) {
    return str.substring(str.indexOf(prefix) + 1);
  },

  textBefore: function(str, prefix) {
    return str.split(prefix)[0];
  },

  //This function is here to avoid any call while running Cypress.
  //If you want to delay a function call, juste use setTimeout as usual.
  executeAfter: function(function_delayed, time_in_ms) {
    if (window.Cypress) {
      // Do nothing
    } else {
      setTimeout(function_delayed, time_in_ms)
    }
  },

  //See https://stackoverflow.com/a/14794066/2595513
  isIntegerLike: function(value) {
    return !isNaN(value) && (function(x) { return (x | 0) === x; })(parseFloat(value))
  },

  // keep only last char of string
  keepOnlyLast: function(str, char) {
    var local_str = str.toString();
    var local_char = char.toString().charAt(0);

    var local_array = local_str.split("")
    var last_index = _.lastIndexOf(local_array, char)


    var current_str = ""
      
    if (last_index >= 0) {
      _.each(local_array, function(current_char, current_index) {
        if (current_char !== local_char) {
          current_str += current_char
        } else if (current_char === local_char && current_index === last_index) {
          current_str += current_char
        }
      })
    } else {
      current_str = local_str
    }

    return current_str;
  },

  none: function () {
    return !_.some.apply(_, arguments);
  },

  isNotEmpty: function () {
    return _.negate(_.isEmpty).apply(_, arguments)
  },

  count: function () {
    return _.defaultTo(_.countBy.apply(_, arguments)[true], 0);
  },

  isNotBlank: function () {
    return _.negate(_.isBlank).apply(_, arguments)
  },

  // https://stackoverflow.com/a/15643382/2595513
  findNested: function (obj, key, memo) {
    var i,
      proto = Object.prototype,
      ts = proto.toString,
      hasOwn = proto.hasOwnProperty.bind(obj);

    if ('[object Array]' !== ts.call(memo)) memo = [];

    for (i in obj) {
      if (hasOwn(i)) {
        if (i === key) {
          memo.push(obj[i]);
        } else if ('[object Array]' === ts.call(obj[i]) || '[object Object]' === ts.call(obj[i])) {
          _.findNested(obj[i], key, memo);
        }
      }
    }

    return memo;
  },

  deepSearch: function (object, key, predicate) {
    if (object && object.hasOwnProperty(key) && predicate(key, object[key]) === true) return object

    for (var i = 0; i < _.keys(object).length; i++) {
      if (typeof object[_.keys(object)[i]] === "object") {
        var o = _.deepSearch(object[_.keys(object)[i]], key, predicate)
        if (o != null) return o
      }
    }
    return null
  },

  isBlank: function (value) {
    if (_.isNumber(value)) {
      return value.toString() === "0" || value.toString() === "NaN";
    } else if (_.isString(value)) {
      return !_.trim(value);
    } else if (!_.isArray(value) && _.isObject(value) && !_.isPlainObject(value)) {
      return false;
    } else {
      return _.isEmpty(value);
    }
  },
  insertAt: function (array, index, item) {
    if (_.isArray(array) && _.isInteger(index)) {
      array.splice(index, 0, item);
    }
  },

});
