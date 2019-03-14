
clara.js_define("admin_rule_save", {

  please_if: _.stubFalse,

  please: function(evt, store) {
    var state = store.getState();
    var simul = state.current_simulation;

    var url = $(evt.currentTarget).closest(".c-simulator-registration").attr("data-url");

    $.ajax({
      url: url,
      type:'POST',
      dataType:'json',
      data:{
        simulation: {
          result: simul.result,
          name: simul.name
        },
        asker: simul.params,
        authenticity_token: window._token
      },
      success:function(data){
        window.location.reload();
      }
    });

  },


});
