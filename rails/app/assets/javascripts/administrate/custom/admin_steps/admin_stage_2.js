clara.js_define("admin_stage_2", {

    please_if: function() {
      return $(".c-newaid--stage2").exists();
    },

    please: function() {

      // unfold description field
      $("#accordion_0-0_tab").click();


      clara.admin_stage_steps.please(2);

      $("button.js-hide-convention").click(function () {
        $(".alert-convention").hide()
        $.ajax({
          url: $(".alert-convention").data("url"),
          type: "POST",
          data: {
            authenticity_token: window._token
          }
        });
      })

      function sth_changed() {
        var ALERT_MSG = "Attention, vous avez des modifications en cours non enregistrées. Quitter quand même la page ?"
        $("button.c-newaid-actionrecord").removeAttr("disabled");
        $(".c-newaid-stageinside a").on("click", function() {
          $(".c-newaid-stage--1 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--3 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--4 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
          $(".c-newaid-stage--5 .c-newaid-stageinside a").attr("data-confirm", ALERT_MSG)
        })
        $(".c-newaid-back2").on("click", function() {
          $(this).attr("data-confirm", ALERT_MSG)
        })

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
