clara.js_define("admin_stage_3", {

    please_if: function() {
      return $(".c-newaid--stage3").exists();
    },

    please: function() {

      clara.admin_stage_steps.please(3);

      var txt_update = function() {
        var slug = $.urlParam("slug")
        var $txt = $(".c-resultaid__smalltxt--" + slug)
        var new_textarea_value = $("#aid_short_description").val();
        $txt.text(new_textarea_value)
      }

      // init text first
      txt_update();      

      // detect change to change button behaviour
      function sth_changed() {
        $("button.c-newaid-actionrecord").removeAttr("disabled");
        $(".c-newaid-stageinside a").on("click", function() {
          var ALERT_MSG = "Attention, vous avez des modifications en cours non enregistrées. Quitter quand même la page ?"
          $(".c-newaid-stage--1 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--2 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--4 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--5 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
        })
      }
      // hack to have access to selectize "onChange" event
      window.detect_selectize_change = function() {
        sth_changed()
      }
      $("#aid_short_description").on("input change keyup paste", function() {
        txt_update();
        sth_changed();
      })



    }

});
