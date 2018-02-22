_.mixin({

  toPropArray: function (obj) {
    return _.map(obj, function(value, prop) {
      return { prop: prop, value: value };
    });
  },

  // from https://davidwalsh.name/query-string-javascript
  getUrlParameter: function(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
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
  
  allIds: function(collection) {
    var good_input = _.isArray(collection) && !_.isEmpty(collection) && _.every(collection, function(e){return _.has(e, 'id');});
    if (good_input) return _.map(collection, function(e){return e.id;});
    return [];
  },

  none: function() {
    return !_.some.apply(_, arguments);
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
