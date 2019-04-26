clara.js_define("admin_delete", {

    please_if: function() {
      return $("a[data-confirm]").length > 0;
    },

    please: function() {


      $.rails.allowAction = function(link) {
        if (!link.attr('data-confirm')) { 
          return true; 
        }
        showConfirmDialog(link); // look bellow for implementations
        return false; // always stops the action since code runs asynchronously
      };

      var showConfirmDialog = function(link) {

        //trigger modal
        $("button.c-deletion").click();

        // setup backfocus
        var id = (new Date()).getTime();
        $("#label_modal_1").attr("id", "label_modal_1_" + id)
        $(link).attr("id", "label_modal_1");
        $("#js-modal-close").attr("data-focus-back", "label_modal_1");

        // if user confims, then go delete the item
        $("button.c-deletion-confirm").on("click", function(){confirmed(link)});
      }


      var confirmed = function(link) {
        $('body').pleaseWait();
        link.removeAttr('data-confirm');
        return link.trigger('click.rails');
      };


  }

});

