clara.js_define("callback_question", {

  please_if: function () {
    return $('.c-callback').length > 0
  },

  please: function () {

    function check_count(count) {
      if (count === 0) {
        $(".c-callback-submit").hide();
      } else {
        $(".c-callback-submit").show();
      }
    }

    function check_montant(value) {
      if (_.isBlank(value)) {
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

    if ($("input[type='checkbox']").exists() || $("input[type='radio']").exists()) {
      $("input[type='checkbox']").click(check_all)
      $("input[type='radio']").click(check_all)      
    } else {
      var $montant = $("input#montant")

      $('input#montant').val($.betterFloat($('input#montant').val()))
      $('input#montant').on('input', function(e) { $(this).val($.betterFloat($(this).val())) })


      $montant.on("keyup", function(e) {
        var kc = e.keyCode;
        check_montant($montant.val())
      });
    }


    setTimeout(check_all, 1000)
  }
});

