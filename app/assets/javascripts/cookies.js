load_js_for_page(["cookies", "edit"], function() {

  $("input:radio:first").focus();

  $("#authorize_all").prop("checked", true);

  if($("#authorize_all").is(":checked")) {
    $("#authorize_statistic").prop("checked", true);
    $("#authorize_navigation").prop("checked", true);
  };

  $("#authorize_all").click(function() {
    $("#authorize_statistic").prop("checked", true);
    $("#authorize_navigation").prop("checked", true);
  });

  $("#forbid_all").click(function() {
    $("#forbid_statistic").prop("checked", true);
    $("#forbid_navigation").prop("checked", true);
  });

  $("#forbid_statistic").click(function() {
    $('input[name=control_all]').prop('checked',false);
  });

  $("#forbid_navigation").click(function() {
    $('input[name=control_all]').prop('checked',false);
  });

  $("#authorize_navigation").click(function() {
    if($("#authorize_statistic").is(":checked")) {
      $("#authorize_all").prop("checked", true);
    };
  });

  $("#authorize_statistic").click(function() {
    if($("#authorize_navigation").is(":checked")) {
      $("#authorize_all").prop("checked", true);
    };
  });

  $("#forbid_navigation").click(function() {
    if($("#forbid_statistic").is(":checked")) {
      $("#forbid_all").prop("checked", true);
    };
  });

  $("#forbid_statistic").click(function() {
    if($("#forbid_navigation").is(":checked")) {
      $("#forbid_all").prop("checked", true);
    };
  });

});
