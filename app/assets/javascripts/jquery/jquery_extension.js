$.paramUpdate = function (url, param) {

  var regExp = new RegExp(param.key + '=([a-z0-9\-\_]+)(?:&)?'),
    existsMatch = url.match(regExp);

  if (!existsMatch) {
    return url + '&' + param.key + '=' + param.value
  }

  var paramToUpdate = existsMatch[0],
    valueToReplace = existsMatch[1],
    updatedParam = paramToUpdate.replace(valueToReplace, param.value);

  return url.replace(paramToUpdate, updatedParam);
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
    } else {
      result = ""; // param present but empty
    }
  } else {
    result = null; // param not present
  }
  return result;
};

$.currentUrl = function () {
  return window.location.href;
}

$.extend({
  // See https://stackoverflow.com/a/20469901/2595513
  replaceTag: function (currentElem, newTagObj, keepProps) {
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
});


jQuery.fn.extend({
  // See https://stackoverflow.com/a/20469901/2595513
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
  },
  hasAttribute: function (name) {
    return $(this).attr(name) !== undefined || null;
  }


});
