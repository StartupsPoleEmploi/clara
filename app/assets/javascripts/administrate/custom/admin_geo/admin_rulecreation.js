clara.js_define("admin_rulecreation", {

    please_if: function() {
      return $(".c-rulecreation").exists();
    },

    please: function() {

        clara.admin_simple_rule_form.dress();
        clara.admin_sortable.please();


        var default_subbox = {
          name: "box",

          subcombination: "",
          subboxes: [],

          xval: "",
          xop: "",
          xvar: "",

          is_editing: false,
          is_new: false
        }


        var trundle_state = {
          name: "root_box",
          subcombination: "",
          subboxes: [],

        }

        var create_new_box = function() {
          var res = _.cloneDeep(default_subbox);
          res["name"] = "box_" + new Date().getTime()
          res["is_editing"] = true
          res["is_new"] = true
          return res
        }

        // REDUCER
        var reducer = function(state, action) { 

          // Deep copy of previous state to avoid side-effects
          var newState = _.cloneDeep(state);

          if (action.type === 'VARIABLE_CHANGED') {
          } else if (action.type === 'OPERATOR_CHANGED') {
            newState["selected_operator"] = action.value
          } else if (action.type === 'VALUE_CHANGED') {
          }

          return newState;
        };

        // STORE
        window.trundle_store = Redux.createStore(reducer, trundle_state);

        // SUBSCRIBER
        main_store.subscribe(function(){

        });

        // DISPATCHERS
        $('button.add-condition').on('click', function(e) {
          console.log(e)
          // var value = $(this).find("option:selected").attr("data-name");
          // main_store.dispatch({type: 'VARIABLE_CHANGED', value: value});
        });


    
    }

});

