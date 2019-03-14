
clara.js_define("admin_rule_ajax_resolve", {

  please_if: _.stubFalse,

  please: function() {

      var keys = $(".simulator-field").map(function(i,e){return $(e).find(".simulator-field__left label").attr("for")}).toArray();
      var values = $( "input[name^='asker']" ).map(function(i,e){return $(e).val()}).toArray();
      var current_asker = _.reduce(keys, function(acc, elt, idx) {acc[elt] = values[idx];return acc}, {})

      var mydata = {
        asker: current_asker,
        authenticity_token: window._token
      };

      $.ajax({
        url: $("#btn_simulate").attr("data-url"),
        type:'GET',
        dataType:'json',
        data: mydata,
        success: function (res) {
          console.log(res)
          action_value = {
            result: res,
            params: mydata.asker
          };
          main_store.dispatch({type: 'SIMULATION_SUBMITTED', value:action_value });
        }
      });

    
  },


 });
