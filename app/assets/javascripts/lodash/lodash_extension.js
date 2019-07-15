_.mixin({

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
  slugify(str) {
    str = str.replace(/^\s+|\s+$/g, ''); // trim
    str = str.toLowerCase();
    
    str = _.deburr(str);

    str = str.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
        .replace(/\s+/g, '-') // collapse whitespace and replace by -
        .replace(/-+/g, '-'); // collapse dashes

    return str;
  }

});
