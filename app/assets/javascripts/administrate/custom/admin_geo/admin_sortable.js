clara.js_define("admin_sortable", {

    please_if: _.stubFalse,

    please: function() {

        $('ul.sortable').sortable({
          items: "li:not(.unsortable)",
          connectWith: 'ul.sortable',
          placeholder: 'placeholder',
          update: function (e) {
            var id_of = function($elt){var res = $elt.attr("data-box").slice(4); return res === "_box" ? "root_box" : res}
            var container = e.target;
            var deplaced = e.toElement;

            // var $leaf = $(deplaced).closest("li.c-leaf");
            // var $parent = $leaf.closest("ul.sortable");

            // deplaced_box_id = id_of($leaf)
            // parent_box_id = id_of($parent)

            console.log(container)
            console.log(deplaced)
            console.log(e)
            console.log("")

            // console.log(deplaced)
            // console.log($leaf)
            // console.log($parent)
            // console.log(deplaced_box_id)
            // console.log(parent_box_id)
            // console.log('')

          },
          start: function (e) {
            // console.log('started')
            // var deplaced = e.toElement;
            // deplaced.closest("li").childNodes[0].nodeValue = "";
          },
          stop: function (e) {
            // console.log('stopped')
          },
        }).disableSelection();

    
    }

});

