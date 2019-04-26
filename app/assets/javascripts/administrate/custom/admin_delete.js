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
        console.log("heyehey");
        $("button.c-deletion").click();
        $("button.c-deletion-confirm").on("click", function(){confirmed(link)});
      }


      var confirmed = function(link) {
        link.removeAttr('data-confirm');
        return link.trigger('click.rails');
      };

      // $('a[data-confirm]').on('click', function() {$.rails.confirmed(link)} );

  }

});

