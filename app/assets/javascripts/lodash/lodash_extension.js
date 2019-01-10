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

  fullDateFr: function() {
    var now = new Date();
 
    var annee   = now.getFullYear();
    var mois    = ('0'+(now.getMonth()+1)).slice(-2);
    var jour    = ('0'+now.getDate()   ).slice(-2);
    var heure   = ('0'+now.getHours()  ).slice(-2);
    var minute  = ('0'+now.getMinutes()).slice(-2);
    var seconde = ('0'+now.getSeconds()).slice(-2);
    var ms = ('0'+now.getMilliseconds()).slice(-2);
    return jour + "/" + mois + "/" + annee + " " + heure + "h" + minute + "m" + seconde + "s" + ms + "ms"
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
