clara.js_define("autofocus_firefox", {

  please_if: function() {
    return $("input.c-field").hasAttribute("autofocus");
  },

  please: function() {
    $( "input:visible:first" ).focus();
  }

});