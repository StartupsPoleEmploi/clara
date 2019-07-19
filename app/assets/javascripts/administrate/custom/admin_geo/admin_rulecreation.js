clara.js_define("admin_rulecreation", {

    please_if: function() {
      return $(".c-rulecreation").exists();
    },

    please: function() {


        clara.admin_simple_rule_form.dress();
        store_rule.subscribe(function(){clara.admin_apprule_update_button.please(_.cloneDeep(store_rule.getState()))});

        

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
          return res
        }

        // REDUCER
        var reducer = function(state, action) { 

          // Deep copy of previous state to avoid side-effects
          var newState = _.cloneDeep(state);

          if (action.type === 'VALIDATED_RULE') {
            console.log('I validated a rule with action')
            console.log(action)
            console.log('')
            var node_targeted = _.deepSearch(newState, "name", function(k, v){return v === action.parent_box})
            console.log(node_targeted)
            var new_box  = create_new_box();
            new_box.xvar = action.value_var
            new_box.xop  = action.value_op
            new_box.xval = action.value_val
            console.log(new_box)
            node_targeted.subboxes.push(new_box)
          } else if (action.type === 'OPERATOR_CHANGED') {
            newState["selected_operator"] = action.value
          } else if (action.type === 'VALUE_CHANGED') {
          }

          return newState;
        };

        // STORE
        window.store_trundle = Redux.createStore(reducer, trundle_state);

        // SUBSCRIBER

        store_trundle.subscribe(function(){

        });

        // DISPATCHERS
        $('button.c-apprule-button.is-validation').on('click', function(e) {
          var value_var = $("#rule_variable_id").find("option:selected").attr("data-name");
          var value_op = $("#rule_operator_kind").find("option:selected").val();
          var is_selection = $("#rule_value_eligible_selectible").is(":visible")
          var value_val_sel = $("#rule_value_eligible_selectible").find("option:selected").val();
          var value_val_inp = $("#rule_value_eligible").val();
          var value_val = is_selection ? value_val_sel : value_val_inp
          var parent_box = $(this).closest("ul.sortable").attr("data-box")
          store_trundle.dispatch({
            type: 'VALIDATED_RULE', 
            value_var: value_var,
            value_op:  value_op,
            value_val: value_val,
            parent_box: parent_box
          });
        });

        // //START
        store_rule.dispatch({type: 'INIT'});
        store_trundle.dispatch({type: 'INIT'});
    
    }

});

