
clara.js_define("admin_rule_remove", {

  please_if: _.stubFalse,

  please: function(evt, store) {
    var that = this;
    $.ajax({
      url: $(evt.currentTarget).attr("data-url"),
      type:'DELETE',
      dataType:'json',
      data:{
        authenticity_token: window._token
      },
      success:function(data){
        window.location.reload();
      }
    });
  },


});
