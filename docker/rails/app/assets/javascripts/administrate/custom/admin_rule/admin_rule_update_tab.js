
clara.js_define("admin_rule_update_tab", {

  please_if: _.stubFalse,

  please: function(s) {
    if (s.is_controlling) {
      $(".c-detail-tab").hide();
      $(".c-simulation-tab").show();
      $(".js-simulation-button").show();
      $(".js-detail-button").hide();
    } else {
      $(".c-detail-tab").show();
      $(".c-simulation-tab").hide();
      $(".js-simulation-button").hide();
      $(".js-detail-button").show();
    }
  },


 });
