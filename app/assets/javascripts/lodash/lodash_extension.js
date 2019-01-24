_.mixin({

  toPropArray: function (obj) {
    return _.map(obj, function(value, prop) {
      return { prop: prop, value: value };
    });
  },

  toPercentage: function(portion, total) {
    if (_.every(arguments, _.isNumber)) {
      return ((portion/total) * 100).toFixed(1) + '%'
    }
    return ''
  },

  voidString: function(str) {
    var result = "" 
    if (_.isString(str)) {
      result = str;
    }
    return result;
  },

  // returns next element in an array, returns first element if last is given
  nextElementLooped: function (array, element) {
    
    if (!(_.isArray(array) && !_.isEmpty(array))) return null;

    var current_index = _.findIndex(array, function(e) {return _.isEqual(e, element)});

    if (_.isEqual(current_index, -1)) return null;

    var last_index  = array.length - 1;
    if (_.isEqual(current_index, last_index)) { // last element
      return array[0];
    } else {
      return array[current_index + 1];
    }
  },

  fromPropArray: function (propArray) {
    return _.reduce(propArray, function(obj, e, key) {
      var z = {};
      z[e.prop] = e.value;
      _.assign(obj, z);
      return obj;
    }, {});

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


  injectToPropArray: function (source, destination) {

    _.each(destination, function(e) {
      if (_.isObject(e) && e.prop) {
        var sourceElt = _.find(source, function(s) {
           return _.isEqual(s.prop, e.prop)
        });
        if (sourceElt) {
          e.value = sourceElt.value;
        } else {
          e.value = null;
        }
      }
    });

  }

});
