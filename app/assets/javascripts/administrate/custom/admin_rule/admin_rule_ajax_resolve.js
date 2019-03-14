
clara.js_define("admin_rule_ajax_resolve", {

  please_if: _.stubFalse,

  please: function() {

      var that = this;

      var keys = $(".simulator-field").map(function(i,e){return $(e).find(".simulator-field__left label").attr("for")}).toArray();
      var values = $( "input[name^='asker']" ).map(function(i,e){return $(e).val()}).toArray();
      var current_asker = _.reduce(keys, function(acc, elt, idx) {acc[elt] = values[idx];return acc}, {})

      return {
        asker: current_asker,
        authenticity_token: window._token
      };

    
  },


 });
