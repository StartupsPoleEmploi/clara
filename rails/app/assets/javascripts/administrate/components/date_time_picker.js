$(function () {
  $(".datetimepicker").datetimepicker({
    debug: false,
    format: "DD/MM/YYYY",
    locale: 'fr'
  });

  $(".datetimepicker").each(function() {
    var $e = $(this);
    if (_.isNotBlank($e.attr("data-frvalue"))) {
      $e.val($e.attr("data-frvalue"));
    }
  })

});
