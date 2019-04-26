clara.js_define("admin_delete", {

    please_if: function() {
      return $("a[data-confirm]").length > 0;
    },

    please: function() {

      $.rails.allowAction = function(link) {
        if (!link.attr('data-confirm')) { return true; }
        const result = link.attr('data-modal-result');
        if (result) {
          link.removeAttr('data-modal-result');
          return result === 'true';
        } else {
          $.rails.showConfirmDialog(link);
          return false;
        }
      };

      $.rails.showConfirmDialog = function(link) {
        console.log("hey");
        console.log(link);
      }
    }
});

