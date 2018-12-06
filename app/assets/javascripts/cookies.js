_.set(window, 'clara.cookies', {

    trigger_function: function() {
      return $("body").hasClasses("cookies", "edit");
    },

    main_function: function() {
      $("input:radio:first").focus();
      clara.cookies.setup_authorize_all_callbacks();
      clara.cookies.setup_forbid_all_callbacks();
      clara.cookies.setup_initial_radiobuttons_state();
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
    },

    setup_initial_radiobuttons_state: function() {
      if( $("#ga-script").length === 1) {
        $("#authorize_statistic").prop("checked", true);
      } else {
        $("#forbid_statistic").prop("checked", true);
      }
      if( $("#hj-script").length === 1 ) {
        $("#authorize_navigation").prop("checked", true);
      } else {
        $("#forbid_navigation").prop("checked", true);
      }      
    }
});



clara.load_js(
  clara.cookies.trigger_function,
  clara.cookies.main_function
);
  
