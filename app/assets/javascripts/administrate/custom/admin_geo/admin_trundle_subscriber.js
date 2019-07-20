clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var s = state;
      var $root = $(".root_box");
      
      var $varopval = $("section.varopval");
      $varopval.attr("data-box", "")
      $("#rule_variable_id").val("")
      $("#rule_operator_kind").val("")
      $("#rule_value_eligible_selectible").val("")
      $("#rule_value_eligible").val("")
      $(".c-comb--edition").remove()
      store_rule.dispatch({type: 'VARIABLE_CHANGED', value: ""});
      $varopval.hide();
      

      $varopval.appendTo(".c-rulecreation");

      $root.empty();
      var walk_nodes = this.walk_nodes;
      $("#main-apprule-expl").empty();
      
      walk_nodes(s);
    },

    walk_nodes: function(obj) {
      var that = clara.admin_trundle_subscriber;
      var parent_name = obj.name;
      var parent_combination = obj.subcombination;
      if (_.size(obj.subboxes) > 0) {
        _.each(obj.subboxes, function(subbox) {
          that.paint_node(subbox, parent_name, parent_combination);
          that.walk_nodes(subbox);
        })
      }
    },

    paint_node: function(node, parent_name, parent_combination) {
      console.log("painting " + node.name + " with parent " + parent_name + " parent_combination " + parent_combination)
      var that = clara.admin_trundle_subscriber;
      var $parent = $("." + parent_name)
      var comb = parent_combination === "AND" ? "ET" : parent_combination === "OR" ? "OU" : "" 

      if (node.is_editing) {
        $("#rule_variable_id").val(node.xvar)
        $("#rule_operator_kind").val(node.xop)
        $("#rule_value_eligible_selectible").val(node.xval)
        $("#rule_value_eligible").val(node.xval)
        store_rule.dispatch({type: 'VARIABLE_CHANGED', value: node.xvar});
        store_rule.dispatch({type: 'OPERATOR_CHANGED', value: node.xop});
        store_rule.dispatch({type: 'VALUE_CHANGED', value: node.xval});

        $("section.varopval").appendTo($parent)
        $("section.varopval").show()
        $( "<span class='c-comb c-comb--edition'>" + comb + "</span>" ).insertBefore( "section.varopval" );
        $("section.varopval").attr("data-box", node.name)
      } else if (_.isNotBlank(node.subcombination)) {
        var $node_tpl = $(that.node_template(node.name, parent_combination));
        $node_tpl.appendTo($parent)
      } else {
        var $leaf_tpl = $(that.leaf_template(node, parent_name, parent_combination))
        $leaf_tpl.appendTo($parent)
      }
    },

    node_template: function(name, combination) {
      var comb = combination === "AND" ? "ET" : combination === "OR" ? "OU" : "" 
      return  "<span class='c-comb'>" + comb + "</span>" +
              '<ul class="sortable ui-sortable '+name+'" data-box="'+name+'"></ul>'
              
    },

    leaf_template: function(node, parent_name, combination) {
      var comb = combination === "AND" ? "ET" : combination === "OR" ? "OU" : "" 
      return '\
              <li class="ui-sortable-handle '+node.name+'" data-box="'+node.name+'" data-xvar="'+node.xvar+'" data-xop="'+node.xop+'" data-xval="'+node.xval+'">' +
                "<span class='c-comb'>" + comb + "</span>" +
                '<ul class="sortable ui-sortable pos-relative">\
                  <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition_' + node.name + '" data-tooltip-title="' + node.xtxt +'" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_' + node.name + '">' + node.xtxt + '</button>\
                </ul>\
                <div id="tooltip_id_condition_' + node.name + '" class="hidden">\
                  <div>\
                    <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "' + parent_name + '" });\'>Créer une nouvelle condition, liée par un ET</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link add-condition-or" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "OR", parent_box: "' + parent_name + '" });\'>Créer une nouvelle condition, liée par un OU</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link add-subcondition-et" onclick=\'store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: "AND", box_name: "' + node.name + '" });\'>regrouper avec une nouvelle sous-condition, liée par un ET</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link add-subcondition-or" onclick=\'store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: "OR", box_name: "' + node.name + '" });\'>regrouper avec une nouvelle sous-condition, liée par un OU</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link edit-condition" onclick=\'store_trundle.dispatch({ type: "EDIT_CONDITION", box_name: "' + node.name + '"  });\'>Editer cette condition</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link remove-condition" onclick=\'store_trundle.dispatch({ type: "REMOVE_CONDITION", box_name: "' + node.name + '"  });\'>Supprimer cette condition</button>\
                  </div>\
                </div>\
              </li>\
              '
    },
});

