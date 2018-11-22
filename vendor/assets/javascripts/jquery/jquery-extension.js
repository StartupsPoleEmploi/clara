$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^]*)').exec(window.location.href);
    if (results==null){
       return null;
    }
    else{
       return results[1] || 0;
    }
}

jQuery.fn.extend({
  datamap: function(dataext) {
    return this.map(function(){return $(this).data()[dataext]}).get();
  },
  hasClasses: function() {
    var args = Array.prototype.slice.call(arguments);
    var result = false;
    for (var i = args.length - 1; i >= 0; i--) {
      var clazz = "" +  args[i]; // force clazz to be a String
      console.log(clazz);
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
