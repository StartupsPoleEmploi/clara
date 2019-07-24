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


            var current_tree = [];
            clara.admin_rulecreation._parse(store_trundle.getState(), function(obj, parent){current_tree.push({obj:obj, parent: parent})});
            console.log(current_tree)

            var new_tree = $("*[data-box]").map(function(i,e){var that=this;return {name:$(that).data("box"), parent: $(that).parent().closest("*[data-box]").data("box")}}).toArray();
            _.remove(new_tree, function(e){return _.isBlank(e.name)})
            new_tree = _.map(new_tree, function(e){if (_.isBlank(e.parent) && e.name !== "root_box"){e.parent="root_box"};return e})

            var simplified_tree = _.map(current_tree, function(e){return {name: e.obj.name, parent: e.parent ? e.parent.name : undefined}})

            var element_who_changed_parent = _.find(new_tree, function(e,i){return e.parent !== simplified_tree[i].parent})
            if (element_who_changed_parent) {

            } else {
              // var element_who_changed_position = 
            }

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

