$.currentAppPath = function() {
  return $('body').attr("data-path");
}

$.urlParam = function(name) {
  var result = null;
  var candidates_array = new RegExp('[\?&]' + name + '=([^&#]*)').exec($.currentUrl());
  if ($.isArray(candidates_array) && candidates_array.length > 1) {
    if (typeof candidates_array[1] === "string") {
      result = decodeURIComponent(candidates_array[1]); // param present and filled
    } else {
      result = ""; // param present but empty
    }
  } else {
    result = null; // param not present
  }
  return result;
};

$.currentUrl = function() {
  return window.location.href;
}

jQuery.fn.extend({
  datamap: function(dataext) {
    return this.map(function(){return $(this).data()[dataext]}).get();
  },
  hasClasses: function() {
    var result = false;
    var args = Array.prototype.slice.call(arguments);
    for (var i = args.length - 1; i >= 0; i--) {
      var clazz = "" +  args[i]; // force clazz to be a String
      if ($(this).hasClass(clazz)) {
        result = true;
      } else {
        result = false;
        break;
      }
    }
    return result;
  }
});
