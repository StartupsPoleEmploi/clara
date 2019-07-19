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
          xtxt: "",

          is_editing: true,
          is_new: true
        }

        var create_new_box = function() {
          var res = _.cloneDeep(default_subbox);
          res["name"] = "box_" + new Date().getTime()
          return res
        }

        var trundle_state = {
          name: "root_box",
          subcombination: "",
          subboxes: [create_new_box()],

        }


        // REDUCER
        var reducer = function(state, action) { 
          console.log('trundle reducer reacted with')
          console.log(action)
          console.log('')

          // Deep copy of previous state to avoid side-effects
          var newState = _.cloneDeep(state);

          if (action.type === 'VALIDATED_RULE') {
            // var node_targeted = _.deepSearch(newState, "name", function(k, v){return v === action.parent_box})
            // var new_box  = create_new_box();
            // new_box.xvar = action.value_var
            // new_box.xop  = action.value_op
            // new_box.xval = action.value_val
            // new_box.xtxt = action.value_txt
            // new_box["is_editing"] = false
            // new_box["is_new"] = false
            // node_targeted.subboxes.push(new_box)
          } else if (action.type === 'ADD_CONDITION') {
            var node_targeted = _.deepSearch(newState, "name", function(k, v){return v === action.parent_box})
            var new_box  = create_new_box();
            new_box.xvar = ""
            new_box.xop  = ""
            new_box.xval = ""
            new_box["is_editing"] = true
            new_box["is_new"] = true
            node_targeted.subboxes.push(new_box)
            // console.log('added condition')
            // console.log('')
          }

          return newState;
        };

        // STORE
        window.store_trundle = Redux.createStore(reducer, trundle_state);

        // SUBSCRIBER
        store_trundle.subscribe(function(){clara.admin_trundle_subscriber.please(_.cloneDeep(store_trundle.getState()))});


        // DISPATCHERS
        $('button.c-apprule-button.is-validation').on('click', function(e) {
          console.log('is-validation clicked? yes')
          var value_txt = $(".expl-text").text();
          var value_var = $("#rule_variable_id").find("option:selected").attr("data-name");
          var value_op = $("#rule_operator_kind").find("option:selected").val();
          var is_selection = $("#rule_value_eligible_selectible").is(":visible")
          var value_val_sel = $("#rule_value_eligible_selectible").find("option:selected").val();
          var value_val_inp = $("#rule_value_eligible").val();
          var value_val = is_selection ? value_val_sel : value_val_inp
          var parent_box = $(this).closest("ul.sortable").attr("data-box")
          store_trundle.dispatch({
            type: 'VALIDATED_RULE', 
            value_txt: value_txt,
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

