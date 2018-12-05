_.set(window, 'clara.cookies', {
    authorize_all: function() {
      $("#authorize_all").click(function() {
        $("#authorize_statistic").prop("checked", true);
        $("#authorize_navigation").prop("checked", true);
      });
    },
    forbid_all: function() {
      $("#forbid_all").click(function() {
        $("#forbid_statistic").prop("checked", true);
        $("#forbid_navigation").prop("checked", true);
      });
    },
    radiobuttons_state: function() {

    };
});



clara.load_js(function only_if(){return $("body").hasClasses("cookies", "edit")}, function() {


  $("input:radio:first").focus();
  clara.cookies.authorize_all();
  clara.cookies.forbid_all();

});
  
