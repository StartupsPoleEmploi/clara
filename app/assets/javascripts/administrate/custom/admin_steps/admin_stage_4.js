clara.js_define("admin_stage_4", {

    please_if: function() {
      return $(".c-newaid--stage4").exists();
    },

    please: function() {
      clara.admin_stage_steps.please(4);


      // detection change
      function sth_changed() {
        $("button#record_root_rule").removeAttr("disabled");
      }
      // hack to access to store_trundle modification
      window.decision_tree_changed = function(){
        sth_changed();
      }
      // hack to access to selectize modification
      window.detect_selectize_change = function(){
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
