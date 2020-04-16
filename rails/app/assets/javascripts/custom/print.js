clara.js_define("global_print", {

    please_if: function() {
      return $(".c-breadcrumb-printer").exists();
    },

    please: function() {
      $(".c-breadcrumb-printer__item").click(function(e) {
        if (typeof ga === "function") {
          ga("send", "event", "results", "share", document.location.pathname);
        }
        var lenTwo = function(val){
          if (val.toString().length === 1) {
            return ('0'+val)
          } else {
            return val;
          }
        }
        var d = new Date();
        var now = lenTwo(d.getDay()) +"/"+lenTwo(d.getMonth())+"/"+d.getFullYear();
        var subject = 'Ma simulation d\'aides Clara du ' + now;
        var body = window.location.href;
        window.location.href = 'mailto:?subject=' + subject + '&body=' + body;
      });
    }

});
