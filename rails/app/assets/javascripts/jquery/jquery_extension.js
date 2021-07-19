$.betterFloat = function(value_arg) {
  var value = value_arg.replace("." ,",");
  var invalid_char_function = function(e){return !_.includes("0123456789,",e)};
  var invalid_char = _.find(value, invalid_char_function);
  value = value.replace(invalid_char, "")
  value = _.keepOnlyLast(value, ",")
  return value;
}

$.currentAppPath = function () {
  return $('body').attr("data-path");
}

$.urlParam = function (name) {
  var result = null;
  var candidates_array = new RegExp('[\?&]' + name + '=([^&#]*)').exec($.currentUrl());
  if ($.isArray(candidates_array) && candidates_array.length > 1) {
    if (typeof candidates_array[1] === "string") {
      result = decodeURIComponent(candidates_array[1]); // param present and filled
    }
  } else {
    result = null; // param not present
  }
  return result;
};

$.currentUrl = function () {
  return window.location.href;
}


// jQuery-scoped replaceTag
// See https://stackoverflow.com/a/20469901/2595513
$.replaceTag = function (currentElem, newTagObj, keepProps) {
  var $currentElem = $(currentElem);
  var i, $newTag = $(newTagObj).clone();
  if (keepProps) {
    newTag = $newTag[0];
    newTag.className = currentElem.className;
    $.extend(newTag.classList, currentElem.classList);
    $.extend(newTag.attributes, currentElem.attributes);
  }
  $currentElem.wrapAll($newTag);
  $currentElem.contents().unwrap();
  return this;
}


jQuery.fn.extend({
  // See https://stackoverflow.com/a/20469901/2595513
  // element-based replaceTag, not as same above
  replaceTag: function (newTagObj, keepProps) {
    return this.each(function () {
      jQuery.replaceTag(this, newTagObj, keepProps);
    });
  },
  datamap: function (dataext) {
    return this.map(function () { return $(this).data()[dataext] }).get();
  },
  exists: function () {
    return this.length > 0;
  },
  hasClasses: function () {
    var result = false;
    var args = Array.prototype.slice.call(arguments);
    for (var i = args.length - 1; i >= 0; i--) {
      var clazz = "" + args[i]; // force clazz to be a String
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

(function (a) {
    a.fn.replaceTagName = function (f) {
        var g = [],
            h = this.length;
        while (h--) {
            var k = document.createElement(f),
                b = this[h],
                d = b.attributes;
            for (var c = d.length - 1; c >= 0; c--) {
                var j = d[c];
                k.setAttribute(j.name, j.value)
            }
            k.innerHTML = b.innerHTML;
            a(b).after(k).remove();
            g[h - 1] = k
        }
        return a(g)
    }
})(window.jQuery);


