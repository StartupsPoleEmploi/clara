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
  }
});
