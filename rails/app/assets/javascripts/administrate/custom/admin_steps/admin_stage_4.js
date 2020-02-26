clara.js_define("admin_stage_4", {

    please_if: function() {
      return $(".c-newaid--stage4").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(4);

      //CSS hack
      $(".sortable").width(($(".c-newaid-belowstages").width() - 50) + "px")

      // detection change
      function sth_changed() {
        $("button#record_root_rule").removeAttr("disabled");
        var ALERT_MSG = "Attention, vous avez des modifications en cours non enregistrées. Quitter quand même la page ?"
        $(".c-newaid-stageinside a").on("click", function() {
          $(".c-newaid-stage--1 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--2 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--3 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--5 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
        })
        $(".c-newaid-back2").on("click", function() {
          $(this).attr("data-confirm", ALERT_MSG)
        })
      }
      // hack to access to store_trundle modification
      window.decision_tree_changed = function(){
        sth_changed();
      }
      // hack to access to selectize modification
      window.detect_selectize_change = function(){
        console.log("detect_selectize_change ok")
        sth_changed();
      }
      // radiobutton change
      var originally_checked = $('.c-geowhere input[type="radio"]:checked').attr("id");
      $('.c-geowhere input[type="radio"]').change(function(){
        var now_selected_id = $('.c-geowhere input[type="radio"]:checked').attr("id")
        if (now_selected_id !== originally_checked) {
          sth_changed();
        }
      }) 




    }
    
});
