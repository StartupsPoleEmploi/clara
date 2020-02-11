clara.js_define("track_outbound_link", {

  please_if: _.stubFalse,

  // See https://support.google.com/analytics/answer/7478520?hl=fr
  please: function(url, target) {

    var link_obj = {'href': url};

    if (target === "_blank") {
      link_obj["target"]  = "_blank"
    }

    ga('send', 'event', 'outbound', 'click', url, {
     'transport': 'tag',
     'hitCallback': function() {
        $('<a />', link_obj).get(0).click();
     }
   });      

  },

});
