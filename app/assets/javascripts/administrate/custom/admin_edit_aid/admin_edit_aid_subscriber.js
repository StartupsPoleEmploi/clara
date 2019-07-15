clara.js_define("admin_edit_aid_subscriber", {

  please_if: _.stubFalse,

  please: function(state) {
    if (state.title) {
      $(".js-title").html(state.title);
    }
    if (state.additionnal_conditions) {
      $(".js-additionnal-conditions").html(state.additionnal_conditions);
    }
    if (state.how_and_when) {
      $(".js-how-and-when").html(state.how_and_when);
    }
    if (state.how_much) {
      $(".js-how-much").html(state.how_much);
    }
    if (state.limitations) {
      $(".js-limitations").html(state.limitations);
    }
    if (state.what) {
      $(".js-what").html(state.what);
    }
    if (state.contract) {
      $(".js-contract").html(state.contract);
    }
  }


});
