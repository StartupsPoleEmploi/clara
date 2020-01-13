clara.js_define("admin_stage_2", {

    please_if: function() {
      return $(".c-newaid--stage2").exists();
    },

    please: function() {

      // unfold description field
      $("#accordion_0-0_tab").click();


      clara.admin_stage_steps.please(2);


      function sth_changed() {
        $("button.c-newaid-actionrecord").removeAttr("disabled");
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

        CKEDITOR.instances['aid_additionnal_conditions'].on( 'key', sth_changed);
        CKEDITOR.instances['aid_how_and_when'].on( 'key', sth_changed);
        CKEDITOR.instances['aid_how_much'].on( 'key', sth_changed);
        CKEDITOR.instances['aid_limitations'].on( 'key', sth_changed);
        CKEDITOR.instances['aid_what'].on( 'key', sth_changed);

      }, 1200)
    }

});
