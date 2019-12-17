_.mixin({

  //See https://stackoverflow.com/a/14794066/2595513
  isIntegerLike: function(value) {
    return !isNaN(value) && (function(x) { return (x | 0) === x; })(parseFloat(value))
  },

  // keep only last char of string
  keepOnlyLast: function(str, char) {
    return "";
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
