clara.js_define("callback_question", {

  please_if: function () {
    return $('.c-callback').length > 0
  },

  please: function () {
    var count = 0;
    $("input[type='checkbox']").click(function () {
      count = $("input[type='checkbox']:checked").length
    })
    $("input[type='radio']").click(function () {
      count = $("input[type='radio']:checked").length
    })
  }
});

