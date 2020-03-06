clara.js_define("new_filter_question", {

    please: function() {
      var key_of_last_known_results_page_state = 
        _.getLastLocalStorageItemWhoseKeyStartsWith("state_of");

      if (window.localStorage && key_of_last_known_results_page_state) {
        var last_state_str = localStorage.getItem(key_of_last_known_results_page_state)
        console.log("last_state_str")
        console.log(key_of_last_known_results_page_state)
        console.log(last_state_str)
        var last_state = JSON.parse(last_state_str)
        console.log("last_state")
        console.log(last_state)
        _.each(_.get(last_state, "filters_zone.filters"), function(obj) {
          $('input[value="' + obj.name + '"]').prop("checked", obj.is_checked);
        })


        $('.c-fieldset input[type="checkbox"]').on("click", function(e) {
          var $e = $(this);
          var slug_of_filter = $e.attr("value");
          var actually_checked = $e.prop("checked");
          console.log("slug_of_filter")
          console.log(slug_of_filter)
          console.log(actually_checked)
          var filter_to_change = _.find(_.get(last_state, "filters_zone.filters"), function(a_filter) {
            return a_filter.name === slug_of_filter
          });
          filter_to_change.is_checked = actually_checked;
          localStorage.setItem(key_of_last_known_results_page_state, JSON.stringify(last_state))
        });

      }


    },

});

