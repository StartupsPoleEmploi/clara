clara.js_define("aides_update_filtering", {

  please_if: _.stubFalse,

  please: function(ely, contract, aid, filters){
        var aid_filters_name = _.map(aid.filters, function(e) {return e.name});
        var existing_filters_name = _.map(_.filter(filters, function(f){return f.is_checked}), function(e) {return e.name});
        var has_intersection = _.isNotEmpty(_.intersection(aid_filters_name, existing_filters_name));
        var no_filter = _.isEmpty(_.filter(filters, function(e){return e.is_checked === true}))

        // aid state
        if (no_filter) {
          aid.is_collapsed = false;
        } else if (has_intersection) {
          aid.is_collapsed = false;
        } else {
          aid.is_collapsed = true;
        }

        // collapse all contracts        
        contract.is_collapsed = true;         
  }

});
