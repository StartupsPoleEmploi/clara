clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var that = clara.admin_trundle_subscriber;
      var s = state;

      that._hide_varopval();
      $(".root_box").empty();
      $("#main-apprule-expl").empty();

      
      if (clara.admin_rulecreation._calculate_actual_boxes_size(s) === 1 && s.subboxes[0].is_editing !== true) {
        var help_text = that.first_expl(s.subboxes[0].xtxt)
        $("#main-apprule-expl").html(help_text)
        $(".first_expl.is-first").show("fade", {}, 1000)
        $(".first_expl.is-last").show("fade", {}, 1000)
      }

      that.walk_nodes(s);
      that._setup_buttons(s);


    },
    
    _setup_buttons: function(s) {
      if (!clara.admin_rulecreation._is_editing(s)) {
        var andor =             
            "<li class='unsortable'>" +
              "<button class='c-apprule-button js-and'>ET</button>" +
              "<button class='small-left-margin c-apprule-button js-or'>OU</button>" +
            "</li>";

        $("ul.sortable").append(andor);

        $(".js-and, .js-or").on("click", function(e) {
          var $target = $(e.currentTarget);
          var $friend = $target.parent().prev();
          var is_subcondition = $friend.is("button.js-tooltip");
          var is_or = $target.is(".js-or");
          var combination = is_or ? "OR" : "AND"

          if (is_subcondition) {
            var $id = $friend.attr("id")
            var box_name = $id.slice($id.indexOf("box_"))
            store_trundle.dispatch({ type: "ADD_SUBCONDITION", combination: combination, box_name: box_name });            
          } else { // is_condition
            var parent_box = $friend.parent().data("box")
            store_trundle.dispatch({ type: "ADD_CONDITION", combination: combination, parent_box });
          } 
        });
      }
    },

    _hide_varopval: function() {
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
    },
    


    first_expl: function(txt) {
      return  '<div class="first_expl is-first" style= "display: none">' +
                    '⚠ Cliquez sur une condition pour l\'éditer ou la supprimer' +
                 '</div>' +
                 '<div class="first_expl is-last" style= "display: none">' +
                    '⚠⚠ Une fois que vous avez renseigné plusieurs conditions, vous pourrez utiliser le glissé-deposé en cliquant sur les pointillés pour modifier l\'imbrication des règles' +
                 '</div>'
    },

    walk_nodes: function(obj) {
      var that = clara.admin_trundle_subscriber;
      var parent_name = obj.name;
      var parent_combination = obj.subcombination;
      if (_.size(obj.subboxes) > 0) {
        _.each(obj.subboxes, function(subbox, indx) {
          that.paint_node(subbox, parent_name, parent_combination, indx);
          that.walk_nodes(subbox);
        })
      }
    },

    paint_node: function(node, parent_name, parent_combination, indx) {
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
        $( "<div class='c-comb c-comb--edition'>" + comb + "</div>" ).insertBefore( "section.varopval" );
        $("section.varopval").attr("data-box", node.name)

        $('button.js-tooltip').each(function(e,i) {
          var $buttonjstooltip = $(this);
          $buttonjstooltip.replaceWith('<div>' + $buttonjstooltip.html() +'</div>')
        })

        $("#rule_variable_id").effect( "bounce", {times:4, distance: 40}, 600 );

      } else if (_.isNotBlank(node.subcombination)) {
        var $node_tpl = $(that.node_template(node.name, parent_combination, parent_name, indx));
        $node_tpl.appendTo($parent)
      } else {
        var $leaf_tpl = $(that.leaf_template(node, parent_name, parent_combination, indx))
        $leaf_tpl.appendTo($parent)
      }
    },

    comb_template: function(combination, name, indx) {
      var comb = combination === "AND" ? "ET" : combination === "OR" ? "OU" : "" 

      var uid =  Math.random().toString(36).substring(2) + new Date().getTime().toString(36);

      var tpl_str = "<div class='c-comb pos-relative'>" +
                        "<button class='js-tooltip like-a-link add-condition' data-tooltip-content-id='tooltip_id_comb_<%= uid %>' data-tooltip-title='Bloc <%= comb %>' data-tooltip-prefix-class='combinator' data-tooltip-close-text='x' data-tooltip-close-title='Ferme la fenêtre' id='label_tooltip_<%= uid %>'><%= comb %></button>" +
                        "<div id='tooltip_id_comb_<%= uid %>' class='hidden'>" +
                          "<% if (comb === 'ET') { %>" +
                            // "<div>" +
                            //   "<button class='like-a-link add-condition-and' onclick='store_trundle.dispatch({ type: \"ADD_CONDITION\", combination: \"AND\", parent_box: \"<%= name %>\" });'>ET une nouvelle condition</button>" +
                            // "</div>" +
                            "<div>" +
                              "<button class='like-a-link change-condition-to-or' onclick='store_trundle.dispatch({ type: \"CHANGE_CONDITION\", combination: \"OR\", parent_box: \"<%= name %>\" });'>changer en OU toutes les conditions de même niveau</button>" +
                            "</div>" +
                          "<% } %>" +
                          "<% if (comb === 'OU') { %>" +
                            // "<div>" +
                            //   "<button class='like-a-link add-condition-or' onclick='store_trundle.dispatch({ type: \"ADD_CONDITION\", combination: \"OR\", parent_box: \"<%= name %>\" });'>OU une nouvelle condition</button>" +
                            // "</div>" +
                            "<div>" +
                              "<button class='like-a-link change-condition-to-and' onclick='store_trundle.dispatch({ type: \"CHANGE_CONDITION\", combination: \"AND\", parent_box: \"<%= name %>\" });'>changer en ET toutes les conditions de même niveau</button>" +
                            "</div>" +
                          "<% } %>" +
                        "</div>"
                    "</div>";
      
      if (comb === "" || indx === 0) {
        tpl_str = ""
      }

      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'comb': comb, 'uid' : uid, 'name' : name});

      return templateHTML; 
    },

    node_template: function(name, combination, parent_name, indx) {

      var tpl_str = 

      '<li class="c-node ui-sortable-handle"  >' +
          clara.admin_trundle_subscriber.comb_template(combination, parent_name, indx) +
          "<ul class='sortable ui-sortable <%= name %>' data-box='<%= name %>'>" +
            // "<li>" +
            //   "<button class='c-apprule-button'>ET une autre condition</button>" +
            //   "<button class='small-left-margin c-apprule-button'>OU une autre condition</button>" +
            // "</li>" +
          "</ul>" +
      "</li>";
      
      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'name': name });

      return templateHTML; 
    },

    leaf_template: function(node, parent_name, combination, indx) {
      
      var tpl_str = '\
        <li class="c-leaf ui-sortable-handle <%= node_name %>" data-box="<%= node_name %>" data-xvar="<%= node_xvar %>" data-xop="<%= node_xop %>" data-xval="<%= node_xval %>">' +
          clara.admin_trundle_subscriber.comb_template(combination, parent_name, indx) +
          '<ul class="sortable ui-sortable pos-relative">\
            <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition_<%= node_name %>" data-tooltip-title="<%= node_xtxt %>" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_<%= node_name %>"><%= node_xtxt %></button>\
          </ul>\
          <div id="tooltip_id_condition_<%= node_name %>" class="hidden">\
            <div>\
              <button class="like-a-link edit-condition" onclick=\'store_trundle.dispatch({ type: "EDIT_CONDITION", box_name: "<%= node_name %>"  });\'>Corriger cette condition</button>\
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

