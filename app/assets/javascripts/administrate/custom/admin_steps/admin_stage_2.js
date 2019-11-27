clara.js_define("admin_stage_2", {

    please_if: function() {
      return $(".c-newaid--stage2").exists();
    },

    please: function() {

      // unfold description field
      $("#accordion_0-0_tab").click();

      var is_modifying = $.urlParam("modify") === "true";
      var slug = $.urlParam("slug");

      localStorage.setItem("stage2_" + slug, "true")

      if (!is_modifying) {
        var has_reached_stage3 = localStorage.getItem("stage3_" + slug);
        var has_reached_stage4 = localStorage.getItem("stage4_" + slug);
        var has_reached_stage5 = localStorage.getItem("stage5_" + slug);
        if (has_reached_stage3) {
          $(".c-newaid-stage--3 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_3?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 3</a>')          
        }
        if (has_reached_stage4) {
          $(".c-newaid-stage--4 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_3?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 3</a>')          
        }
        if (has_reached_stage5) {
          $(".c-newaid-stage--5 .c-newaid-stageinside").html('<a href="/admin/aid_creation/new_aid_stage_3?locale=fr&amp;modify=' + is_modifying + '&slug=' + slug + '">Étape 3</a>')          
        }
      }


      // give focus to description field
      setTimeout(function(){

        function give_focus_to_description() {
          CKEDITOR.instances["aid_what"].focus()
        }

        if (document.activeElement.id === "js-tooltip-close") {
          $("#js-tooltip-close").on("click", function() {
            give_focus_to_description()
          })
        } else  {
          give_focus_to_description()
        }


      }, 1200)
    }

});
