clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var s = state
      
      $("#main-apprule-expl").empty()
     
      if (_.size(s.subboxes) !== 0) {
        $("section.varopval").hide();
        $("section.varopval").appendTo("#main-apprule");        
      } 
     
      if (_.size(s.subboxes) === 1 && !$(".first_template_only").exists()) {
        var $root = $(".root_box")
        $("#main-apprule-expl").hide()
        $("#main-apprule-expl").html(this.first_expl)
        $("#main-apprule-expl").show(600)
        $(this.first_template(s.subboxes[0].xtxt)).appendTo($root)
      }


    },


    first_expl: '<div>\
                    Si c\'est la seule règle, vous pouvez passer au critère géographique ci-dessous.\
                 </div>\
                 <div>\
                   Sinon, cliquez sur la règle.\
                 </div>\
                ',

    first_template: function(title) {
      return '<ul class="unsortable ui-sortable first_template_only">\
          <li class="unsortable ui-sortable-handle">\
            <span class="combinator-container">\
              <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition" data-tooltip-title="' + title +'" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_2">' +
                title +
              '</button>\
            </span>\
            <div id="tooltip_id_condition" class="hidden">\
              <div>\
                <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", box: "root_box" });\'>ET autre(s) condition(s)</button>\
              </div>\
              <div>\
                <button class="like-a-link add-condition-or">OU autre(s) condition(s)</button>\
              </div>\
              <div>\
                <button class="like-a-link edit-condition">Editer cette condition</button>\
              </div>\
              <div>\
                <button class="like-a-link close-window">Fermer cette fenêtre</button>\
              </div>\
            </div>\
          </li>\
          <li class="unsortable">\
          </li>\
        </ul>\
      '
  },
});

