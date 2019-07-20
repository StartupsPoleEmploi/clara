clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var s = state;
      var $root = $(".root_box");
      
      var $varopval = $("section.varopval");
      $varopval.attr("data-box", "")
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

      if (node.is_editing) {
        console.log('painting edition')
        $("section.varopval").appendTo($parent)
        $("section.varopval").show()
        $("section.varopval").attr("data-box", node.name)
      } else if (_.isNotBlank(node.subcombination)) {
        console.log('painting node')
        var $node_tpl = $(that.node_template(node.name));
        $node_tpl.appendTo($parent)
      } else {
        console.log('painting leaf')
        var $leaf_tpl = $(that.leaf_template(node.xtxt, node.name, parent_name, parent_combination))
        $leaf_tpl.appendTo($parent)
      }
      console.log('')
    },

    node_template: function(name) {
      return '\
                <ul class="sortable ui-sortable '+name+'" data-box="'+name+'">\
                </ul>\
              '
    },

    leaf_template: function(title, name, parent_name, combination) {
      // var french_combination = combination ? (combination === "AND" ? "ET" : "OU") : ""
      // var combined_with = combination ? '<span class="c-comb c-comb--' + combination.toLowerCase() + '">' + french_combination + ' </span>' : ''
      // console.log(combined_with);
      return '\
              <li class="ui-sortable-handle '+name+'" data-box="'+name+'">\
                ET\
                <ul class="sortable ui-sortable pos-relative">\
                  <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition_' + name + '" data-tooltip-title="' + title +'" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_' + name + '">' + title + '</button>\
                </ul>\
                <div id="tooltip_id_condition_' + name + '" class="hidden">\
                  <div>\
                    <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "' + parent_name + '" });\'>ET une nouvelle condition</button>\
                  </div>\
                  <div>\
                    <button class="like-a-link add-subcondition-or" onclick=\'store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: "OR", box_name: "' + name + '" });\'>regrouper avec une nouvelle sous-condition, liée par un OU</button>\
                  </div>\
                </div>\
              </li>\
              '
    },
});

