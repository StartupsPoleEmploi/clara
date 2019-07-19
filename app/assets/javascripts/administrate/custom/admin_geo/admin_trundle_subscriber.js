clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {
      var s = state
      console.log("state")
      console.log(state)
      
      $("#main-apprule-expl").empty()
     
      if (_.size(s.subboxes) !== 0) {
        $("section.varopval").hide();
        $("section.varopval").appendTo("#main-apprule");        
      } 
     
      if (_.size(s.subboxes) === 1) {
        var $root = $(".sortable.is-first .unsortable")
        $("#main-apprule-expl").html(this.first_expl)
        $(this.template).appendTo($root)
      }


    },


    first_expl: '<div>\
                    Si c\'est la seule règle, vous pouvez passer au critère géographique ci-dessous.\
                 </div>\
                 <div>\
                   Sinon, cliquez sur la règle.\
                 </div>\
                ',

    template: '<ul class="unsortable ui-sortable">\
          <li class="unsortable ui-sortable-handle">\
            <span class="combinator-container">\
              <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition" data-tooltip-title="Avoir au moins 18 ans" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_2">\
                Avoir au moins 18 ans\
              </button>\
            </span>\
            <div id="tooltip_id_condition" class="hidden">\
              <div>\
                <button class="like-a-link">ET une autre condition</button>\
              </div>\
              <div>\
                <button class="like-a-link">OU une autre condition</button>\
              </div>\
              <div>\
                <button class="like-a-link">Editer cette condition</button>\
              </div>\
              <div>\
                <button class="like-a-link">Supprimer cette condition</button>\
              </div>\
              <div>\
                <button class="like-a-link">Fermer cette fenêtre</button>\
              </div>\
            </div>\
          </li>\
          <li class="unsortable">\
          </li>\
        </ul>\
      '

});

