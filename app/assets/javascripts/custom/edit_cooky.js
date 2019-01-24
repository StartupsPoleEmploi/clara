clara.js_define("edit_cooky", {

    main_function: function() {
      var that = this;
      $("input:radio:first").focus();
      that.setup_authorize_all_callbacks();
      that.setup_forbid_all_callbacks();
    },

    setup_authorize_all_callbacks: function() {
      $("#authorize_all").click(function() {
        $("#authorize_statistic").prop("checked", true);
        $("#authorize_navigation").prop("checked", true);
      });
    },

    setup_forbid_all_callbacks: function() {
      $("#forbid_all").click(function() {
        $("#forbid_statistic").prop("checked", true);
        $("#forbid_navigation").prop("checked", true);
      });
    }
});

