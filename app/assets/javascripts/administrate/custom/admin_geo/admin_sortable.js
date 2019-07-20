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
            console.log('updated')
            // var kind = container.getAttribute("data-type")
            // deplaced.closest("li").childNodes[0].nodeValue = kind;
          },
          start: function (e) {
            console.log('started')
            // var deplaced = e.toElement;
            // deplaced.closest("li").childNodes[0].nodeValue = "";
          },
          stop: function (e) {
            console.log('stopped')
          },
        }).disableSelection();

    
    }

});

