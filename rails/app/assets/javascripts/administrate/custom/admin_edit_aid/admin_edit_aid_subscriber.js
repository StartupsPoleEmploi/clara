clara.js_define("admin_edit_aid_subscriber", {

  please_if: _.stubFalse,

  please: function(state) {
    if (_.isString(state.title)) {
      $(".js-title").html(state.title);
    }
    if (_.isString(state.additionnal_conditions)) {
      $(".js-additionnal-conditions").html(state.additionnal_conditions);
    }
    if (_.isString(state.how_and_when)) {
      $(".js-how-and-when").html(state.how_and_when);
    }
    if (_.isString(state.how_much)) {
      $(".js-how-much").html(state.how_much);
    }
    if (_.isString(state.limitations)) {
      $(".js-limitations").html(state.limitations);
    }
    if (_.isString(state.what)) {
      $(".js-what").html(state.what);
    }
    if (_.isString(state.contract)) {
      $(".js-contract").html(state.contract);
    }
  }


});
