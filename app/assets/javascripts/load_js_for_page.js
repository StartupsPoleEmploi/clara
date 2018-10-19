// load_js_for_page(["welcome", "index"], function() {
// });
/**
*
* Will load JavaScript file for page whose body has classes given in array_of_selectors.
*
* If first parameter is empty array, JavaScript will be loaded for the whole application.
*
* Usage : load_js_for_page(["welcome", "index"], function loaded_function() {});
*
* The JS will be loaded only once, whether "ready" or "turbolinks:load" is called.
*
*/

function load_js_for_page(selectors, a_function, optional_id) {

  // debug purpose only
  var local_id = _.isEmpty(selectors) ? optional_id : selectors.toString();

  // extracted from https://stackoverflow.com/a/52466715/2595513
  function makeSelfDestructingEventCallback(maxExecutions) {
    return function(internal_callback) {
      var countObj = {};
      return function(event) {
        // identify current page
        var current_page = $('body').attr('class').split(" ").join(",");
        // reset all counters that are not from the current page
        countObj = _.resetAllKeysBut(countObj, current_page, 0);
        // increment counter for current page
        countObj[current_page] = _.defaultTo(countObj[current_page], 0) + 1;
        // try to call the the given a_function only if it's belong to the current page (or can be applied to all pages)
        if (should_apply_on_all_pages() || should_apply_on_selected_page()) {
          console.log("for " + local_id + " countObj is " + JSON.stringify(countObj, null, 2));
          // too many call, reset
          if (countObj[current_page] > maxExecutions) {
            countObj[current_page] = 0;
          } else {
            // ok, fire a_function
            return internal_callback.apply(this, arguments); 
          }
        }
      }
    }
    
  }

  var only_one_possible_call = makeSelfDestructingEventCallback(1);

  var should_apply_on_all_pages = function(){
    return _.isEmpty(selectors);
  };

  var should_apply_on_selected_page = function(){ 
    var res = false;
    if(!_.isEmpty(selectors)){
      res = _.every(selectors, function(sel){return $('body').hasClass(sel)});
    }
    return res;
  };

  var call_a_function = function(e) {
    // console.log("function " + local_id + " is called with event " + event.type);
    a_function();
  };
  
  // $(document).on("ready turbolinks:load", function(an_event) {only_one_possible_call(func)(an_event)});
  $(document).on("ready turbolinks:load", only_one_possible_call(call_a_function));

};

