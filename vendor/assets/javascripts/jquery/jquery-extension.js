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
    var that = this;
    var all_args = Array.prototype.slice.call(arguments);
    if (all_args.length < 1) return false;
    var result = true;
    $.each(all_args, function(index, element) {
      result = result && typeof element === "string" && that.hasClass(element);
    });
    return result;
  },
});
