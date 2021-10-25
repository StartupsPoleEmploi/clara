clara.js_define("new_filter_question", {

  please_if: function() {
    return $('form#filter_question_form').exists();
  }, 

  please: function() {

    // focus
    $(".c-navbutton--continue").focus();

    if (window.localStorage) {
      
      // init
      var choosen_filters_str = localStorage.getItem("choosen_filters");
      if (choosen_filters_str) {
        var choosen_filters = JSON.parse(choosen_filters_str);
        _.each(choosen_filters, function(filter_slug) {
          $('input[value="' + filter_slug + '"]').prop("checked", true);
        }) 
      }

      // save
      $('.c-fieldset input[type="checkbox"]').on("click", function(k) {
        var new_choosen_filters = []
        $('.c-fieldset input[type="checkbox"]').each(function(i, e) {
          var $e = $(this);
          var slug_of_filter = $e.attr("value");
          var actually_checked = $e.prop("checked");
          if (actually_checked) {
            new_choosen_filters.push(slug_of_filter)
          }
        })
        localStorage.setItem("choosen_filters", JSON.stringify(new_choosen_filters));
      });
    }

    $('.c-fieldset input[type="checkbox"]').on("click", function(k) {
      var $e = $(this);
      var slug_of_filter = $e.attr("value");
      var actually_checked = $e.prop("checked");
      if (actually_checked) {
        clara.aides_track_filter.please("question__" + slug_of_filter);
      }
    });

    $('form#filter_question_form').submit(function() {
      if ($('.c-fieldset input[type="checkbox"]:checked').length === 0) {
        clara.aides_track_filter.please("question__0");
      }
      return true;
    })

  }

});

