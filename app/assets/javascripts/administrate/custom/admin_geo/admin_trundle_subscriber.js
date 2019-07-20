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
      store_rule.dispatch({type: 'VARIABLE_CHANGED', value: ""});
      // store_rule.dispatch({type: 'INIT'});
      $(".expl-text").html("")
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
      // console.log("painting " + node.name + " with parent " + parent_name + " parent_combination " + parent_combination)
      var that = clara.admin_trundle_subscriber;
      var $parent = $("." + parent_name)

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
        $("section.varopval").attr("data-box", node.name)
      } else if (_.isNotBlank(node.subcombination)) {
        var $node_tpl = $(that.node_template(node.name));
        $node_tpl.appendTo($parent)
      } else {
        var $leaf_tpl = $(that.leaf_template(node, parent_name, parent_combination))
        $leaf_tpl.appendTo($parent)
      }
    },

    node_template: function(name) {
      return '\
                <ul class="sortable ui-sortable '+name+'" data-box="'+name+'">\
                </ul>\
              '
    },

    leaf_template: function(node, parent_name, combination) {
      return '\
              <li class="ui-sortable-handle '+node.name+'" data-box="'+node.name+'" data-xvar="'+node.xvar+'" data-xop="'+node.xop+'" data-xval="'+node.xval+'">\
                <ul class="sortable ui-sortable pos-relative">\
                  <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition_' + node.name + '" data-tooltip-title="' + node.xtxt +'" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_' + node.name + '">' + node.xtxt + '</button>\
                </ul>\
                <div id="tooltip_id_condition_' + node.name + '" class="hidden">\
                  <div>\
                    <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "' + parent_name + '" });\'>ET une nouvelle condition</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "EDIT_CONDITION", box_name: "' + node.name + '"  });\'>Editer cette condition</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link add-subcondition-or" onclick=\'store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: "OR", box_name: "' + node.name + '" });\'>regrouper avec une nouvelle sous-condition, liée par un OU</button>\
                  </div>\
                </div>\
              </li>\
              '
    },
});

