clara.js_define("callback_question", {

  please_if: function () {
    return $('.c-callback').length > 0
  },

  please: function () {

    function check_count(count) {
      console.log(`count ${count}`)
      if (count === 0) {
        $(".c-callback-submit").hide();
      } else {
        $(".c-callback-submit").show();
      }
    }

    function check_all() {
      var count = 0
      count = $("input[type='checkbox']:checked").length;
      count += $("input[type='radio']:checked").length;
      check_count(count)
    }

    $("input[type='checkbox']").click(check_all)
    $("input[type='radio']").click(check_all)

    setTimeout(check_all, 1000)
  }
});

