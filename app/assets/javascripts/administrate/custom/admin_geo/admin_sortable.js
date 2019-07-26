clara.js_define("admin_sortable", {

    please_if: _.stubFalse,

    please: function() {

        $('ul.sortable').sortable({
          items: "li:not(.unsortable)",
          connectWith: 'ul.sortable',
          placeholder: 'placeholder',
          update: function (e) {
            var result = {};

            var current_tree = [];
            clara.admin_rulecreation._parse(store_trundle.getState(), function(obj, parent, indx){current_tree.push({obj:obj, parent: parent})});

            var n_tree = $("*[data-box]").map(function(i,e){var that=this;return {name:$(that).data("box"), parent: $(that).parent().closest("*[data-box]").data("box")}}).toArray();
            _.remove(n_tree, function(e){return _.isBlank(e.name)})
            n_tree = _.map(n_tree, function(e){if (_.isBlank(e.parent) && e.name !== "root_box"){e.parent="root_box"};return e})

            var s_tree = _.map(current_tree, function(e){return {name: e.obj.name, parent: e.parent ? e.parent.name : undefined}})

            _.remove(n_tree, function(e){return e.name === "root_box"})
            _.remove(s_tree, function(e){return e.name === "root_box"})

            if (!_.isEqual(n_tree, s_tree)) {
              var rn_tree = _.reduce(n_tree, function(acc, val){acc[val.name] = val.parent; return acc;}, {})
              var rs_tree = _.reduce(s_tree, function(acc, val){acc[val.name] = val.parent; return acc;}, {})
              
              var diff = _.objDiff(rn_tree, rs_tree);
              if (_.isBlank(diff)) {
                gn_tree = _.groupBy(n_tree, 'parent')
                gs_tree = _.groupBy(s_tree, 'parent')
                var diffs = _.objDiff(gs_tree, gn_tree);
                var key_of_parent_that_changed = _.keys(diffs)[0]
                result.parent = key_of_parent_that_changed;
                result.childs = _.filter(n_tree, function(e){return e.parent === key_of_parent_that_changed});
                store_trundle.dispatch({
                  type: 'MOVED_POSITION', 
                  value: result,
                });

              } else {
                result.box = _.keys(diff)[0]
                result.new_parent = _.values(diff)[0]
                result.new_position = _.findIndex(_.filter(n_tree, function(e){return e.parent === result.new_parent}), function(g){return g.name === result.box})
                store_trundle.dispatch({
                  type: 'MOVED_PARENT', 
                  value: result,
                });
              }

            }
          },
          start: function (e) {
          },
          stop: function (e) {
          },
        }).disableSelection();

    
    }

});

