clara.js_define("expand_tree", {

    please_if: function() {
      this.clicked = false;
      return $(".c-expand-tree").exists();
    },

    please: function() {
      var that = this;
      $('.c-expand-tree').click(function(e) {
        if (!that.clicked) {
          if (typeof ga === "function") {
            ga('send', 'event', 'results', 'expand', 'yes');
            that.clicked = true;
          }
        }
      });        
    }
});

