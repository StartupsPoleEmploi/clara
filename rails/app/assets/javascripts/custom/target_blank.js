clara.js_define("target_blank", {

  please_if: _.stubTrue,

  please: function() {
    $('a[target="_blank"]').attr("rel", "noreferrer")
  },

});
  
