clara.js_define("intercept_start_by_contract", {

    please_if: function() {
      return $(".c-detail-cta.js-contract").exists();
    },

    please: function() {
      $(".c-detail-cta.js-contract").click(function(e){
          e.preventDefault();
          var href = this.href;

          localStorage.setItem("choosen_filters", JSON.stringify(new_choosen_filters));          

          console.log("hello")
          location.href = href;
      });
    }

});

