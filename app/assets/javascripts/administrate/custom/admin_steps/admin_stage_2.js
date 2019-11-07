clara.js_define("admin_stage_2", {

    please_if: function() {
      return $(".c-newaid--stage2").exists();
    },

    please: function() {
      // unfold description field
      $("#accordion_0-0_tab").click();

      // give focus to description field
      setTimeout(function(){CKEDITOR.instances["aid_what"].focus()}, 500)
    }

});

