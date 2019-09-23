clara.js_define("admin_rulecreation", {

    please_if: function() {
      return $(".c-rulecreation").exists();
    },

    please: function() {

        clara.admin_rulecreation._populate_vars(gon.global_state.variables);
        clara.admin_simple_rule_form.dress();
        store_rule.subscribe(function(){clara.admin_apprule_update_button.please(_.cloneDeep(store_rule.getState()))});


        clara.admin_sortable.please();

        var state_history = []

        var default_subbox = {
          name: "box",

          subcombination: "",
          subboxes: [],

          xval: "",
          xop: "",
          xvar: "",
          xtxt: "",

          is_editing: true,
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
          var that = clara.admin_rulecreation;

          // Deep copy of previous state to avoid side-effects
          var newState = _.cloneDeep(state);

          var initial_size = clara.admin_rulecreation._calculate_actual_boxes_size(newState)

          var is_initially_not_void = initial_size > 1

          if (action.type === 'VALIDATED_RULE') {
            var node_current = _.deepSearch(newState, "name", function(k, v){return v === action.box_name})
            node_current.xvar = action.value_var
            node_current.xop  = action.value_op
            node_current.xval = action.value_val
            node_current.xtxt = action.value_txt
            node_current.is_editing = false
          } else if (action.type === 'ADD_CONDITION') {
            var node_parent = _.deepSearch(newState, "name", function(k, v){return v === action.parent_box})
            var new_box  = create_new_box();
            new_box.xvar = ""
            new_box.xop  = ""
            new_box.xval = ""
            new_box["is_editing"] = true
            node_parent.subcombination = action.combination
            node_parent.subboxes.push(new_box)

          } else if (action.type === 'ADD_SUBCONDITION') {
            
            var node_current = _.deepSearch(newState, "name", function(k, v){return v === action.box_name})
            var cloned = _.cloneDeep(node_current)
            var new_combination_box  = create_new_box();
            var new_editing_box  = create_new_box();
            
            new_combination_box.is_editing = false
            new_editing_box.is_editing = true
            
            new_combination_box.name = cloned.name
            cloned.name = new_editing_box.name + "b"
            new_editing_box.name += "a"

            new_combination_box.subcombination = action.combination
            
            //current node is erased by the new combination box
            _.assign(node_current, new_combination_box);
            
            new_combination_box.subboxes.push(cloned)
            new_combination_box.subboxes.push(new_editing_box)
           } else if (action.type === 'EDIT_CONDITION') {            
              var node_current = _.deepSearch(newState, "name", function(k, v){return v === action.box_name})
              node_current.is_editing = true
           } else if (action.type === 'indow.state_hisCONDITION') { 
              // make it an orphan, it will be removed later           
              var node_current = _.deepSearch(newState, "name", function(k, v){return v === action.box_name})
              var new_default_box  = create_new_box();
              new_default_box.is_editing = !is_initially_not_void
              _.assign(node_current, new_default_box);
           } else if (action.type === 'CANCEL_EDITION') {            
              var ante_previous_state =  state_history.length - 2;
              newState = _.cloneDeep(state_history[ante_previous_state]) 
           } else if (action.type === 'CHANGE_CONDITION') {
              var node_parent = _.deepSearch(newState, "name", function(k, v){return v === action.parent_box})
              node_parent.subcombination = action.combination
           } else if (action.type === 'MOVED_POSITION') {
              var node_searched = _.deepSearch(newState, "name", function(k, v){return v === action.value.parent})
              node_searched.subboxes = _.sortBy(node_searched.subboxes, function(e){return _.findIndex(action.value.childs, function(g) {return g.name === e.name})})
           } else if (action.type === 'MOVED_PARENT') {

              // delete old node by making it an orphan
              var node_current = _.deepSearch(newState, "name", function(k, v){return v === action.value.box})
              var clone = _.cloneDeep(node_current)
              var new_default_box  = create_new_box();
              new_default_box.is_editing = !is_initially_not_void
              _.assign(node_current, new_default_box);

              // find and insert new node
              that._parse(newState, function(obj, parent){
                if (obj.name === action.value.new_parent) {
                  _.insertAt(obj.subboxes, action.value.new_position, clone)
                }
              })

           }


          if (clara.admin_rulecreation._calculate_actual_boxes_size(newState) === 1) {
            newState.subcombination = ""
          }
          if (clara.admin_rulecreation._calculate_actual_boxes_size(newState) === 0) {
            newState = {
              name: "root_box",
              subcombination: "",
              subboxes: [create_new_box()],
            }
          }

          state_history.push(newState)

          return newState;
        };

        // STORE
        var get_default_state = function() {
          var default_state = trundle_state;
          if (_.isNotEmpty(_.get(window, "gon.initial_scope"))) {
            if (_.isEmpty(gon.initial_scope.subcombination)) {
              default_state.subboxes = [gon.initial_scope]
            } else {
              default_state = gon.initial_scope
            }
          }
          return default_state;
        }
        window.store_trundle = Redux.createStore(reducer, get_default_state());

        // SUBSCRIBER
        store_trundle.subscribe(function(){clara.admin_trundle_subscriber.please(_.cloneDeep(store_trundle.getState()))});


        // DISPATCHERS
        $('button.c-apprule-button.is-validation').on('click', function(e) {
          var value_txt = $(".expl-text").text();
          var value_var = $("#rule_variable_id").find("option:selected").attr("data-name");
          var value_op = $("#rule_operator_kind").find("option:selected").val();
          var is_selection = $("#rule_value_eligible_selectible").is(":visible")
          var value_val_sel = $("#rule_value_eligible_selectible").find("option:selected").val();
          var value_val_inp = $("#rule_value_eligible").val();
          var value_val = is_selection ? value_val_sel : value_val_inp
          var box_name = $(this).closest("section").attr("data-box")
          store_trundle.dispatch({
            type: 'VALIDATED_RULE', 
            value_txt: value_txt,
            value_var: value_var,
            value_op:  value_op,
            value_val: value_val,
            box_name: box_name
          });
        });

        //START
        store_rule.dispatch({type: 'INIT'});
        store_trundle.dispatch({type: 'INIT'});
    
    },

    _calculate_actual_boxes_size: function (obj) {
      var box_names = _.uniq(_.findNested(obj, "name"))
      var editable_box_names = _.difference(box_names, ["root_box"])
      return _.size(editable_box_names);
    },

    _parse: function(obj, callback, _parent, _indx) {
      var that = clara.admin_rulecreation;
      callback(obj, _parent, _indx)
      if (_.size(obj.subboxes) > 0) {
        _.each(obj.subboxes, function(subbox, indx) {
          that._parse(subbox, callback, obj, indx);
        })
      }
    },

    _is_editing: function(obj) {
      var result = false;
      clara.admin_rulecreation._parse(obj, function(o){
        if (o.is_editing === true) {
          result = true;
        }
      })
      return result;
    },

    _add_missing_conditions: function(obj) {
      var that = clara.admin_rulecreation;
      that._parse(obj, function(obj){
        if (_.isBlank(obj.subcombination) && _.isNotBlank(obj.subboxes)) {
          if (obj.subboxes[0].subcombination === "AND") {
            obj.subcombination = "OR"
          } else {
            obj.subcombination = "AND"
          }
        }
      })
    },

    _populate_vars: function(variables) {
      $("#rule_variable_id").empty();
      var res = "<option value></option>"
      _.each(variables, function(variable) {
        var name = variable.name;
        var visibility = variable.is_visible
        var txt = variable.name_translation;
        if (_.startsWith(name, "v_location") || visibility !== true) {
          res += ""
        } else {
          res += '<option data-name="' + name + '" value="' + name + '">' + txt + '</option>'
        }
      })
      $("#rule_variable_id").html(res)
    },

});



// EXAMPLE of gon.initial_state

// {
//   "name": "root_box",
//   "subcombination": "OR",
//   "xvar": null,
//   "xop": null,
//   "xval": null,
//   "xtxt": null,
//   "subboxes": [
//     {
//       "name": "box_1568817526246",
//       "subcombination": "",
//       "xvar": "v_allocation_type",
//       "xop": "not_equal",
//       "xval": "ASS_AER_APS_AS-FNE",
//       "xtxt": "Ne pas être bénéficiaire de l'ASS, l'AER, l'APS, ou l'AS-FNE",
//       "subboxes": [],
//       "is_editing": false
//     },
//     {
//       "name": "box_1568817534323",
//       "subcombination": "",
//       "xvar": "v_cadre",
//       "xop": "equal",
//       "xval": "non",
//       "xtxt": "Ne pas être cadre et/ou en recherche d'un poste d'encadrement",
//       "subboxes": [],
//       "is_editing": false
//     }
//   ],
//   "is_editing": false
// }
