_.mixin({

  toPropArray: function (obj) {
    return _.map(obj, function(value, prop) {
      return { prop: prop, value: value };
    });
  },

  // see https://stackoverflow.com/a/43852081/2595513
  toBoolean: function(v) {
    return v==="false" || v==="null" || v==="NaN" || v==="undefined" || v==="0" ? false : !!v; 
  },

  toPercentage: function(portion, total) {
    return ((portion/total) * 100).toFixed(2) + '%'
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
