_.mixin({

  // See https://gist.github.com/Yimiprod/7ee176597fef230d1451
  objDiff: function(object, base) {
    function changes(object, base) {
      return _.transform(object, function(result, value, key) {
        if (!_.isEqual(value, base[key])) {
          result[key] = (_.isObject(value) && _.isObject(base[key])) ? changes(value, base[key]) : value;
        }
      });
    }
    return changes(object, base);
  },

  toPercentage: function(portion, total) {
    if (_.every(arguments, _.isNumber)) {
      return ((portion/total) * 100).toFixed(1) + '%'
    }
    return ''
  },

  none: function() {
    return !_.some.apply(_, arguments);
  },

  isNotEmpty: function() {
    return _.negate(_.isEmpty).apply(_, arguments)
  },

  count: function() {
    return _.defaultTo(_.countBy.apply(_, arguments)[true], 0);
  },

  isNotBlank: function() {
    return _.negate(_.isBlank).apply(_, arguments)
  },

  // https://stackoverflow.com/a/15643382/2595513
  findNested: function(obj, key, memo) {
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

  deepSearch: function(object, key, predicate) {
    if (object && object.hasOwnProperty(key) && predicate(key, object[key]) === true) return object

    for (var i = 0; i < _.keys(object).length; i++) {
      if (typeof object[_.keys(object)[i]] === "object") {
        var o = _.deepSearch(object[_.keys(object)[i]], key, predicate)
        if (o != null) return o
      }
    }
    return null
  },

  isBlank: function(value) {
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
  slugify: function(str) {
    res = "";
    if(_.isString(str)) {
      str = str.replace(/^\s+|\s+$/g, ''); // trim
      str = str.toLowerCase();
      
      str = _.deburr(str);

      str = str.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
          .replace(/\s+/g, '-') // collapse whitespace and replace by -
          .replace(/-+/g, '-'); // collapse dashes

      res = str;
    }
    return res;
  },
  insertAt: function(array, index, item) {
    if (_.isArray(array) && _.isInteger(index)) {
      array.splice( index, 0, item );
    }
  },

});
