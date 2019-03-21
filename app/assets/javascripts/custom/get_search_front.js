clara.js_define("get_search_front", {

    please: function() {
      var val = $("input.c-search-front-usearch").val();
      $(".c-result-aid__subtitle").highlight(val, "c-search-front-highlighted");
    },

    
});

