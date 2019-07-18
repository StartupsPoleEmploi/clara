clara.js_define("admin_sortable", {

    please_if: _.stubFalse,

    please: function() {

        $('ul.sortable').sortable({
          items: "li:not(.unsortable)",
          connectWith: 'ul.sortable',
          placeholder: 'placeholder',
          update: function (e) {
            var container = e.target;
            var deplaced = e.toElement;
            
            var kind = container.getAttribute("data-type")
            deplaced.closest("li").childNodes[0].nodeValue = kind;
          },
          start: function (e) {
            var deplaced = e.toElement;
            deplaced.closest("li").childNodes[0].nodeValue = "";
          },
          stop: function (e) {
          },
        }).disableSelection();

    
    }

});

