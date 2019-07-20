clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var that = clara.admin_trundle_subscriber;
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
      
      if (clara.admin_rulecreation._calculate_actual_boxes_size(s) === 1 && s.subboxes[0].is_editing !== true) {
        var help_text = that.first_expl(s.subboxes[0].xtxt)
        $("#main-apprule-expl").html(help_text)
        $(".first_expl.is-first").show("fade", {}, 1000)
        $(".first_expl.is-last").show("fade", {}, 1000)
      }

      walk_nodes(s);

    },
    
    first_expl: function(txt) {
      return  '<div class="first_expl is-first" style= "display: none">\
                    Si c\'est la seule condition, vous pouvez passer au critère géographique ci-dessous.\
                 </div>\
                 <div class="first_expl is-last" style= "display: none">Sinon, cliquez sur la condition \"' + txt + '\" ci-dessus.</div>'
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

        $('button.js-tooltip').each(function(e,i) {
          var $buttonjstooltip = $(this);
          $buttonjstooltip.replaceWith('<div>' + $buttonjstooltip.html() +'</div>')
        })

        $("#rule_variable_id").effect( "bounce", {times:4, distance: 40}, 600 );

      } else if (_.isNotBlank(node.subcombination)) {
        var $node_tpl = $(that.node_template(node.name, parent_combination));
        $node_tpl.appendTo($parent)
      } else {
        var $leaf_tpl = $(that.leaf_template(node, parent_name, parent_combination))
        $leaf_tpl.appendTo($parent)
      }
    },

    comb_template: function(combination, name) {
      var comb = combination === "AND" ? "ET" : combination === "OR" ? "OU" : "" 

      var uid =  Math.random().toString(36).substring(2) + new Date().getTime().toString(36);

      var tpl_str = "<span class='c-comb pos-relative'>" +
                        "<%= comb %>" +
                    "</span>";

      // var tpl_str = "<span class='c-comb pos-relative'>" +
      //                   "<button class='js-tooltip like-a-link add-condition' data-tooltip-content-id='tooltip_id_comb_<%= uid %>' data-tooltip-title='Bloc <%= comb %>' data-tooltip-prefix-class='combinator' data-tooltip-close-text='x' data-tooltip-close-title='Ferme la fenêtre' id='label_tooltip_<%= uid %>'><%= comb %></button>" +
      //                   "<div id='tooltip_id_comb_<%= uid %>' class='hidden'>" +
      //                     "<% if (comb === 'ET') { %>" +
      //                       "<div>" +
      //                         "<button class='like-a-link add-condition-and' onclick='store_trundle.dispatch({ type: \"ADD_CONDITION\", combination: \"AND\", parent_box: \"<%= name %>\" });'>ET une nouvelle condition</button>" +
      //                       "</div>" +
      //                       "<div>" +
      //                         "<button class='like-a-link change-condition-to-or' onclick='store_trundle.dispatch({ type: \"CHANGE_CONDITION\", combination: \"OR\", parent_box: \"<%= name %>\" });'>changer en OU toutes les conditions de même niveau</button>" +
      //                       "</div>" +
      //                     "<% } %>" +
      //                     "<% if (comb === 'OU') { %>" +
      //                       "<div>" +
      //                         "<button class='like-a-link add-condition-or' onclick='store_trundle.dispatch({ type: \"ADD_CONDITION\", combination: \"OR\", parent_box: \"<%= name %>\" });'>OU une nouvelle condition</button>" +
      //                       "</div>" +
      //                       "<div>" +
      //                         "<button class='like-a-link change-condition-to-and' onclick='store_trundle.dispatch({ type: \"CHANGE_CONDITION\", combination: \"AND\", parent_box: \"<%= name %>\" });'>changer en ET toutes les conditions de même niveau</button>" +
      //                       "</div>" +
      //                     "<% } %>" +
      //                   "</div>"
      //               "</span>";
      
      if (comb === "") {
        tpl_str = ""
      }

      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'comb': comb, 'uid' : uid, 'name' : name});

      return templateHTML; 
    },

    node_template: function(name, combination) {

      var tpl_str = clara.admin_trundle_subscriber.comb_template(combination, name) +
                    "<ul class='sortable ui-sortable <%= name %> data-box='<%= name %>'>"+
                    "</ul>"
      
      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'name': name });

      return templateHTML; 
    },

    leaf_template: function(node, parent_name, combination) {
      
      var tpl_str = '\
  <li class="c-leaf ui-sortable-handle <%= node_name %>" data-box="<%= node_name %>" data-xvar="<%= node_xvar %>" data-xop="<%= node_xop %>" data-xval="<%= node_xval %>">' +
    clara.admin_trundle_subscriber.comb_template(combination, parent_name) +
    '<ul class="sortable ui-sortable pos-relative">\
      <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition_<%= node_name %>" data-tooltip-title="<%= node_xtxt %>" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_<%= node_name %>"><%= node_xtxt %></button>\
    </ul>\
    <div id="tooltip_id_condition_<%= node_name %>" class="hidden">\
      <% if (combination === "AND" || combination === "") { %>\
        <div>\
          <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "<%= parent_name %>" });\'>ET une nouvelle condition</button>\
        </div>\
      <% } %>\
      <% if (combination === "OR" || combination === "") { %>\
        <div>\
          <button class="like-a-link add-condition-or" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "OR", parent_box: "<%= parent_name %>" });\'>OU une nouvelle condition</button>\
        </div>\
      <% } %>\
      <div>\
        <button class="like-a-link add-subcondition-et" onclick=\'store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: "AND", box_name: "<%= node_name %>" });\'>Regrouper avec une nouvelle sous-condition, liée par un ET</button>\
      </div>\
      <div>\
        <button class="like-a-link add-subcondition-or" onclick=\'store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: "OR", box_name: "<%= node_name %>" });\'>Regrouper avec une nouvelle sous-condition, liée par un OU</button>\
      </div>\
      <% if (combination === "OR") { %>\
        <div>\
          <button class="like-a-link change-condition-to-and" onclick=\'store_trundle.dispatch({ type: "CHANGE_CONDITION", combination: "AND", parent_box: "<%= parent_name %>" });\'>Changer tous les OU de même niveau en ET</button>\
        </div>\
      <% } %>\
      <% if (combination === "AND") { %>\
        <div>\
          <button class="like-a-link change-condition-to-or" onclick=\'store_trundle.dispatch({ type: "CHANGE_CONDITION", combination: "OR", parent_box: "<%= parent_name %>" });\'>Changer tous les ET de même niveau en OU</button>\
        </div>\
      <% } %>\
      <div>\
        <button class="like-a-link edit-condition" onclick=\'store_trundle.dispatch({ type: "EDIT_CONDITION", box_name: "<%= node_name %>"  });\'>Editer cette condition</button>\
      </div>\
      <div>\
        <button class="like-a-link remove-condition" onclick=\'store_trundle.dispatch({ type: "REMOVE_CONDITION", box_name: "<%= node_name %>"  });\'>Supprimer cette condition</button>\
      </div>\
    </div>\
  </li>\
  '

      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'combination': combination, 'node_xvar': node.xvar, 'node_xop': node.xop, 'node_xval': node.xval, 'node_name': node.name, 'node_xtxt': node.xtxt, 'parent_name' : parent_name });

      return templateHTML; 
    }
});

