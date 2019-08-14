clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var that = clara.admin_trundle_subscriber;
      var s = state;

      that._hide_varopval();
      $(".root_box").empty();
      $(".c-parentexpl-root_box").empty();

      // $("#main-apprule-expl").empty();      
      // if (clara.admin_rulecreation._calculate_actual_boxes_size(s) === 1 && s.subboxes[0].is_editing !== true) {
      //   var help_text = that.first_expl(s.subboxes[0].xtxt)
      //   $("#main-apprule-expl").html(help_text)
      //   $(".first_expl.is-first").show("fade", {}, 1000)
      //   $(".first_expl.is-last").show("fade", {}, 1000)
      // }

      that.walk_nodes(s);
      that._post_paint(s);

    },
    
    _post_paint: function(s) {
      if (!clara.admin_rulecreation._is_editing(s)) {

        // add buttons
        var andor =             
            "<li class='unsortable'>" +
              "<button class='c-apprule-button js-and'>ET</button>" +
              "<button class='small-left-margin c-apprule-button js-or'>OU</button>" +
              '&nbsp;<span class="c-drag-help"><svg width="15px" height="15px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 362.667 362.667" style="enable-background:new 0 0 362.667 362.667;" xml:space="preserve"> <g> <g> <path d="M298.667,42.667c-8.768,0-16.939,2.667-23.723,7.211c-5.845-16.597-21.696-28.544-40.277-28.544 c-8.768,0-16.939,2.667-23.723,7.211C205.099,11.947,189.248,0,170.667,0c-18.581,0-34.432,11.947-40.277,28.544 c-6.784-4.544-14.955-7.211-23.723-7.211C83.136,21.333,64,40.469,64,64v48.917l-20.8,20.779 c-14.101,14.123-21.867,32.853-21.867,52.8v32.32c0,19.947,7.765,38.699,21.867,52.821l42.688,42.667 c31.168,31.189,72.661,48.363,116.779,48.363c76.459,0,138.667-62.208,138.667-138.667V85.333 C341.333,61.803,322.197,42.667,298.667,42.667z M320,224c0,64.704-52.651,117.333-117.355,117.333 c-38.421,0-74.539-14.955-101.675-42.112l-42.688-42.667c-10.069-10.091-15.616-23.488-15.616-37.717v-32.32 c0-14.251,5.547-27.648,15.616-37.717L64,143.083V160c0,5.888,4.779,10.667,10.667,10.667S85.333,165.888,85.333,160v-42.645 c0-0.021,0-0.021,0-0.043V64c0-11.755,9.557-21.333,21.333-21.333S128,52.245,128,64v32c0,5.888,4.779,10.667,10.667,10.667 s10.667-4.779,10.667-10.667V42.667c0-11.755,9.557-21.333,21.333-21.333S192,30.912,192,42.667V96 c0,5.888,4.779,10.667,10.667,10.667s10.667-4.779,10.667-10.667V64c0-11.755,9.557-21.333,21.333-21.333S256,52.245,256,64v32 c0,5.888,4.779,10.667,10.667,10.667c5.888,0,10.667-4.779,10.667-10.667V85.333c0-11.755,9.557-21.333,21.333-21.333 S320,73.579,320,85.333V224z"/> </g> </g> </svg> glissez-déposez le bloc si nécessaire</span>'
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

        // no dragndrop help if only one box (or none)
        if (clara.admin_rulecreation._calculate_actual_boxes_size(s) < 2) {
          $(".c-drag-help").remove() 
        } else  { // animate the others, the last one is not necessary
          $(".c-drag-help").effect( "bounce", {times:4, distance: 40}, 800 );
          $(".c-drag-help").last().remove() 
        }

      } else {
        // disable all edition
        $('button.js-tooltip').each(function(e,i) {
          var $buttonjstooltip = $(this);
          $buttonjstooltip.replaceWith('<div class="uneditable-condition">' + $buttonjstooltip.html() +'</div>')
        })
        
        // no dragndrop help
        $(".c-drag-help").remove() 
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
      console.log("parent_name");
      console.log(parent_name);
      console.log("");
      
      var expl_parent_name = "c-parentexpl-" + parent_name;
      var that = clara.admin_trundle_subscriber;
      
      var $parent = $("." + parent_name)
      var $expl_parent = $("." + expl_parent_name)

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

      } else if (_.isNotBlank(node.subcombination)) {
        var $node_tpl = $(that.node_template(node.name, parent_combination, parent_name, indx));
        $node_tpl.appendTo($parent)

        var $expl_node_tpl = $(that.expl_node_template("c-parentexpl-" + node.name, parent_combination, expl_parent_name, indx, node.subcombination));
        $expl_node_tpl.appendTo($expl_parent)
      } else {
        var $leaf_tpl = $(that.leaf_template(node, parent_name, parent_combination, indx))
        $leaf_tpl.appendTo($parent)

        var $expl_leaf_tpl = $(that.expl_leaf_template(node, expl_parent_name, parent_combination, indx))
        $expl_leaf_tpl.appendTo($expl_parent)
      }
    },

    comb_template: function(combination, name, indx) {
      var comb = combination === "AND" ? "ET" : combination === "OR" ? "OU" : "" 

      var uid =  Math.random().toString(36).substring(2) + new Date().getTime().toString(36);

      var tpl_str = "<div class='c-comb pos-relative'>" +
                        "<button class='js-tooltip like-a-link add-condition' data-tooltip-content-id='tooltip_id_comb_<%= uid %>' data-tooltip-title='Bloc <%= comb %>' data-tooltip-prefix-class='combinator' data-tooltip-close-text='x' data-tooltip-close-title='Ferme la fenêtre' id='label_tooltip_<%= uid %>'><%= comb %></button>" +
                        "<div id='tooltip_id_comb_<%= uid %>' class='hidden'>" +
                          "<% if (comb === 'ET') { %>" +
                            "<div>" +
                              "<button class='like-a-link change-condition-to-or' onclick='store_trundle.dispatch({ type: \"CHANGE_CONDITION\", combination: \"OR\", parent_box: \"<%= name %>\" });'>changer en OU toutes les conditions de même niveau</button>" +
                            "</div>" +
                          "<% } %>" +
                          "<% if (comb === 'OU') { %>" +
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
    },

    expl_node_template: function(name, combination, parent_name, indx, own_combination) {

      var comb = own_combination === "AND" ? "Toutes les conditions suivantes : " : own_combination === "OR" ? "Au moins une des conditions suivantes : " : "" 

      var add_comb = combination === "AND" ? "<strong>Et</strong> " : combination === "OR" ? "<strong>Soit</strong> " : ""  

      if (combination === "AND" && indx === 0) {
        add_comb = "<strong>D'abord, </strong> "
      }

      var tpl_str = 

      '<li class="c-explnode"  >' +
          add_comb + comb + 
          "<ul class='<%= name %>' data-box='<%= name %>'>" +
          "</ul>" +
      "</li>";
      
      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'name': name });

      return templateHTML; 
    },

    expl_leaf_template: function(node, parent_name, combination, indx) {

      var add_comb = combination === "AND" ? "<strong>Et</strong> " : combination === "OR" ? "<strong>Soit</strong> " : ""  

      if (combination === "AND" && indx === 0) {
        add_comb = "<strong>D'abord, </strong> "
      }

      var tpl_str = 

      '<li class="c-explleaf"  >' +
          add_comb + "<%= node_xtxt %>" +
      "</li>";
      
      var templateFn = _.template(tpl_str);

      var templateHTML = templateFn({ 'combination': combination, 'node_xvar': node.xvar, 'node_xop': node.xop, 'node_xval': node.xval, 'node_name': node.name, 'node_xtxt': node.xtxt, 'parent_name' : parent_name });

      return templateHTML; 
    },

});

