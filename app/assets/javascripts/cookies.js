_.set(window, 'clara.cookies', function() {
    $("#authorize_all").click(function() {
      $("#authorize_statistic").prop("checked", true);
      $("#authorize_navigation").prop("checked", true);
      $("#input_nav").prop("checked", false);
      $("#input_stat").prop("checked", false);
      console.log("byebye")
    });
  }

);

load_js_for_page(["cookies", "edit"], function() {

  $("input:radio:first").focus();

  clara.cookies();

  $("#authorize_all").prop("checked", true);

  if($("#authorize_all").is(":checked")) {
    $("#authorize_statistic").prop("checked", true);
    $("#authorize_navigation").prop("checked", true);
    $("#input_nav").prop("checked", false);
    $("#input_stat").prop("checked", false);
  };

/*  var test = function() {
    $("#authorize_all").click(function() {
      console.log("bb")
      $("#authorize_statistic").prop("checked", true);
      $("#authorize_navigation").prop("checked", true);
      $("#input_nav").prop("checked", false);
      $("#input_stat").prop("checked", false);
    });
  }
  test();*/

/*  $("#authorize_all").click(function() {
    $("#authorize_statistic").prop("checked", true);
    $("#authorize_navigation").prop("checked", true);
    $("#input_nav").prop("checked", false);
    $("#input_stat").prop("checked", false);
  });*/

  $("#forbid_all").click(function() {
    $("#forbid_statistic").prop("checked", true);
    $("#forbid_navigation").prop("checked", true);
    $("#input_nav").prop("checked", true);
    $("#input_stat").prop("checked", true);
  });


  $("#authorize_navigation").click(function() {
    $("#input_nav").prop("checked", false);
    if($("#authorize_statistic").is(":checked")) {
      $("#authorize_all").prop("checked", true);
    };
  });

  $("#authorize_statistic").click(function() {
    $("#input_stat").prop("checked", false);
    if($("#authorize_navigation").is(":checked")) {
      $("#authorize_all").prop("checked", true);
    };
  });

  $("#forbid_navigation").click(function() {
    $('input[name=control_all]').prop('checked',false);
    $("#input_nav").prop("checked", true);
    if($("#forbid_statistic").is(":checked")) {
      $("#forbid_all").prop("checked", true);
    };
  });

  $("#forbid_statistic").click(function() {
    $('input[name=control_all]').prop('checked',false);
    $("#input_stat").prop("checked", true);
    if($("#forbid_navigation").is(":checked")) {
      $("#forbid_all").prop("checked", true);
    };
  });

  })
  
