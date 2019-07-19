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
      if (_.size(obj.subboxes) > 0) {
        _.each(obj.subboxes, function(subbox) {
          that.paint_node(subbox, parent_name);
          that.walk_nodes(subbox);
        })
      }
    },

    paint_node: function(node, parent_name) {
      console.log("painting " + node.name + " with parent " + parent_name + " editing " + node.is_editing)
      var that = clara.admin_trundle_subscriber;
      var $parent = $("." + parent_name)

      if (node.is_editing) {
        $("section.varopval").appendTo($parent)
        $("section.varopval").show()
        $("section.varopval").attr("data-box", node.name)
      } else {
        console.log('node.subcombination')
        console.log(node.subcombination)
        $(that.first_template(node.xtxt, node.name, parent_name, node.subcombination)).appendTo($parent)
      }

    },


    first_expl: '<div>\
                    Si c\'est la seule règle, vous pouvez passer au critère géographique ci-dessous.\
                 </div>\
                 <div>\
                   Sinon, cliquez sur la règle.\
                 </div>\
                ',

    first_template: function(title, name, parent_name, combination) {
      var combined_with = combination ? '<span class="c-comb c-comb--' + _.toLower(combination) + '">' + combination + ' </span>' : ''
      console.log(combined_with);
      return '<ul class="unsortable ui-sortable ' + name + '" data-box="' + name + '">\
                <li class="sortable ui-sortable-handle pos-relative">' + combined_with + '\
                  <span class="combinator-container">\
                    <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition" data-tooltip-title="' + title +'" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_2">' +
                      title +
                    '</button>\
                  </span>\
                  <div id="tooltip_id_condition" class="hidden">\
                    <div>\
                      <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "' + parent_name + '" });\'>ET une nouvelle condition</button>\
                    </div>\
                    <div>\
                      <button class="like-a-link add-condition-or">OU une nouvelle condition</button>\
                    </div>\
                    <div>\
                      <button class="like-a-link add-condition-andsub" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "' + name + '" });\'>regrouper avec une nouvelle sous-condition, liée par un ET</button>\
                    </div>\
                    <div>\
                      <button class="like-a-link add-condition-orsub">regrouper avec une nouvelle sous-condition, liée par un OU</button>\
                    </div>\
                    <div>\
                      <button class="like-a-link edit-condition">Editer cette condition</button>\
                    </div>\
                    <div>\
                      <button class="like-a-link close-window">Fermer cette fenêtre</button>\
                    </div>\
                  </div>\
                </li>\
              </ul>\
      '
  },
});

