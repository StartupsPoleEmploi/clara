clara.js_define("admin_stage_2", {

  please_if: function () {
    return $(".c-newaid--stage2").exists();
  },

  please: function () {

    // unfold description field
    $("#accordion_0-0_tab").click();


    clara.admin_stage_steps.please(2);


    // give focus to description field
    setTimeout(function () {

      function give_focus_to_description() {
        CKEDITOR.instances["aid_what"].focus()
      }

      if (document.activeElement.id === "js-tooltip-close") {
        $("#js-tooltip-close").on("click", function () {
          give_focus_to_description()
        })
      } else {
        give_focus_to_description()
      }


    }, 1200)

    function warn_user_to_save() {
      CKEDITOR.instances["aid_what"].change(function () {
        alert("The text has been changed.");
      })
    }


  }

});
