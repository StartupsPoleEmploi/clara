clara.js_define("track_outbound_link", {

  please_if: _.stubFalse,

  // See https://support.google.com/analytics/answer/7478520?hl=fr
  please: function(url) {

    gtag("event", 
          "clic", 
            {
              "event_category": "sortant",
              "event_label": url,
              "transport_type": "balise",
              "event_callback": function(){
                document.location = url;
              }
            }
    );        

  },

});
