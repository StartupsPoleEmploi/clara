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
            var result = {};
            // var $leaf = $(deplaced).closest("li.c-leaf");
            // var $parent = $leaf.closest("ul.sortable");

            // deplaced_box_id = id_of($leaf)
            // parent_box_id = id_of($parent)

            // console.log(container)
            // console.log(deplaced)
            // console.log(e)
            // console.log("")


            var current_tree = [];
            clara.admin_rulecreation._parse(store_trundle.getState(), function(obj, parent, indx){current_tree.push({obj:obj, parent: parent})});
            // console.log(current_tree)

            var n_tree = $("*[data-box]").map(function(i,e){var that=this;return {name:$(that).data("box"), parent: $(that).parent().closest("*[data-box]").data("box")}}).toArray();
            _.remove(n_tree, function(e){return _.isBlank(e.name)})
            n_tree = _.map(n_tree, function(e){if (_.isBlank(e.parent) && e.name !== "root_box"){e.parent="root_box"};return e})

            var s_tree = _.map(current_tree, function(e){return {name: e.obj.name, parent: e.parent ? e.parent.name : undefined}})

            _.remove(n_tree, function(e){return e.name === "root_box"})
            _.remove(s_tree, function(e){return e.name === "root_box"})

            console.log("n_tree");
            console.log(n_tree);
            console.log("s_tree");
            console.log(s_tree);
            console.log("");


            if (_.isEqual(n_tree, s_tree)) {
              console.log("nothing changed");
            } else {
              console.log("changed");
              // store_trundle.dispatch({
              //   type: 'DRAGNDROP', 
              //   value: n_tree,
              // });
              var rn_tree = _.reduce(n_tree, function(acc, val){acc[val.name] = val.parent; return acc;}, {})
              var rs_tree = _.reduce(s_tree, function(acc, val){acc[val.name] = val.parent; return acc;}, {})
              
              console.log("reduced");
              console.log(rn_tree);
              console.log(rs_tree);
              var diff = _.objDiff(rn_tree, rs_tree);
              if (_.isBlank(diff)) {
                console.log("just changed position, but not my parent");
                gn_tree = _.groupBy(n_tree, 'parent')
                gs_tree = _.groupBy(s_tree, 'parent')
                console.log("diffs")
                var diffs = _.objDiff(gs_tree, gn_tree);
                console.log(diffs)
                var key_of_parent_that_changed = _.keys(diffs)[0]
                console.log("key_of_parent_that_changed")
                console.log(key_of_parent_that_changed)
                result.parent = key_of_parent_that_changed;
                result.childs = _.filter(n_tree, function(e){return e.parent === key_of_parent_that_changed});
                store_trundle.dispatch({
                  type: 'MOVED_POSITION', 
                  value: result,
                });

              } else {
                console.log("OMG!!! CHANGED PARENT !!!")
                console.log(diff)
                console.log("")
              }




              // var elt_guilty = null;
              // _.each(s_tree, function(e, i) {
              //   var comp_with = _.find(n_tree, function(g){return g.name === e.name});
              //   console.log("")
              //   console.log(comp_with)
              //   console.log(e)
              //   console.log("")
              //   elt_guilty = comp_with.parent === e.parent ? null : comp_with;
              //   return !!elt_guilty; // each loop break if false
              // })
              // if (!elt_guilty) {
              //   console.log("elt elt_guilty");
              //   console.log(elt_guilty);
              //   console.log("");                
              // }
            }

            // var element_who_changed_parent = _.find(n_tree, function(e,i){return e.parent !== s_tree[i].parent})
            // if (element_who_changed_parent) {
              // console.log('an element changed its parent !')
              // console.log(element_who_changed_parent)
            // } else {
              // var element_who_changed_position =  
              // var grouped_n_tree = _.groupBy(n_tree, "parent");
              // var grouped_s_tree = _.groupBy(s_tree, "parent");
              // _.find(grouped_n_tree, function(gnt_v, gnt_k) {
              //   console.log("searching key " + gnt_k)
              //   var gst_v = grouped_s_tree[gnt_k]
              //   console.log("gnt_v is  " + gnt_v)
              //   console.log(gnt_v)
              //   console.log("gst_v is  " + gst_v)
              //   console.log(gst_v)
              //   return JSON.stringify(gnt_v) === JSON.stringify(gst_v)
              // })
            // }  

            // console.log(deplaced)
            // console.log($leaf)
            // console.log($parent)
            // console.log(deplaced_box_id)
            // console.log(parent_box_id)
            // console.log('')

            // return result;

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

