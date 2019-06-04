clara.js_define("admin_edit_rule_subscribe", {

  please_if: _.stubFalse,

  please: function(state) {
    $(".js-title").html(state.title);
    $(".js-additionnal-conditions").html(state.additionnal_conditions);
    $(".js-how-and-when").html(state.how_and_when);
    $(".js-how-much").html(state.how_much);
    $(".js-limitations").html(state.limitations);
    $(".js-what").html(state.what);
    $(".js-contract").html(state.contract);
  }


});
