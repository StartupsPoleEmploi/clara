clara.js_define("admin_stage_steps", {

    please_if: _.stubFalse,

    please: function(current_stage_nb) {


      var is_modifying = $.urlParam("modify") === "true";
      var slug = $.urlParam("slug");

      localStorage.setItem("stage" + current_stage + "_" + slug, "true")

      if (!is_modifying) {
        var has_reached_stage2 = localStorage.getItem("stage2_" + slug) === "true";
        var has_reached_stage3 = localStorage.getItem("stage3_" + slug) === "true";
        var has_reached_stage4 = localStorage.getItem("stage4_" + slug) === "true";
        var has_reached_stage5 = localStorage.getItem("stage5_" + slug) === "true";
        
        if (has_reached_stage2 && current_stage_nb < 2) {
          $(".c-newaid-stage--2 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_2?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 2</a>')          
        }
        if (has_reached_stage3 && current_stage_nb < 3) {
          $(".c-newaid-stage--3 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_3?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 3</a>')          
        }
        if (has_reached_stage4 && current_stage_nb < 4) {
          $(".c-newaid-stage--4 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_4?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 4</a>')          
        }
        if (has_reached_stage5 && current_stage_nb < 5) {
          $(".c-newaid-stage--5 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_5?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 5</a>')          
        }
      }


    }

});
