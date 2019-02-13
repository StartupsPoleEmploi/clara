clara.js_define("admin_simple_rule_form", {

  dress: function(){
    var that = this;
    that._order_variables_alphabetically();
    // that._set_callbacks();
  },

  _order_variables_alphabetically: function() {
    $select = $("#rule_variable_id")

    var my_options = $select.find("option");
    var selected = $select.val();

    my_options.sort(function(a,b) {
      var aa = $(a).attr("data-name");
      var bb = $(b).attr("data-name");
      if (aa > bb) return 1;
      if (aa < bb) return -1;
      return 0;
    });

    $select.empty().append( my_options );
    $select.val(selected);
  },

  

});
