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


$.renameElement = function ($element, newElement, keepProps) {

    $element.wrap("<"+newElement+">");
    $newElement = $element.parent();

    if (keepProps) {
      //Copying Attributes
      $.each($element.prop('attributes'), function() {
          $newElement.attr(this.name,this.value);
      });      
    }

    $element.contents().unwrap();       

    return $newElement;
}



jQuery.fn.extend({
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


(function() {
  if ($) {
    var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

    var enable_crsf_header = $('body').data('env') === 'test' && $('.disable-crsf-header').length === 0

    if (enable_crsf_header) {
      $.ajaxSetup( {
        beforeSend: function ( xhr ) {
          xhr.setRequestHeader( 'X-CSRF-Token', token );
        }
      });      
    }
  }
})();
