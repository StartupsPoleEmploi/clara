clara.js_define("admin_geowhere", {

    please_if: function() {
      return $(".c-geowhere").exists();
    },

    please: function() {

        // var department_options = {        
        //   valueField: 'name',
        //   labelField: 'name',
        //   searchField: 'name',
        //   options: [],
        //   create: false,
        //   load: function(query, callback) {
        //     if (!query.length) return callback();
        //     $.get({
        //         url: 'https://api-adresse.data.gouv.fr/search/',
        //         type: 'GET',
        //         dataType: 'json',
        //         data: {
        //           q: query,
        //           type: "municipality"
        //         },
        //         error: function() {
        //             callback();
        //         },
        //         success: function(res) {
        //           var uniq_context = _.uniqBy(res.features, function(e) {
        //             return e.properties.context
        //           });
        //           console.log(uniq_context);
        //           var rez = _.map(uniq_context, function(e){
        //             var displayed = e.properties.context
        //             return {
        //               value: _.slugify(displayed),
        //               name: displayed.split(",")[0] + ", " + displayed.split(",")[1]         
        //             }
        //           })
        //           callback(rez);
        //           // selectize.refreshItems()
        //         }
        //     });
        //   }
        // };
        // $('.c-geoselect--department').selectize()[0].selectize.destroy();
        // $('.c-geoselect--department').selectize(department_options);

        // var region_options = {        
        //   valueField: 'name',
        //   labelField: 'name',
        //   searchField: 'name',
        //   options: [],
        //   create: false,
        //   load: function(query, callback) {
        //     if (query && query.length && query.length > 3) {
        //       console.log("kboom");
        //       $.get({
        //           url: 'https://api-adresse.data.gouv.fr/search/',
        //           type: 'GET',
        //           dataType: 'json',
        //           data: {
        //             q: query,
        //             context: query,
        //           },
        //           error: function() {
        //               callback();
        //           },

        //           success: function(res) {
        //             // console.log(res);
        //             var uniq_region = _.uniqBy(res.features, function(e) {
        //               return e.properties.context.split(",")[2] //region
        //             });
        //             // console.log("uniq_region");
        //             // console.log(uniq_region);
        //             var rez = _.map(uniq_region, function(e){
        //               var displayed = e.properties.context.split(",")[2]
        //               return {
        //                 id: _.slugify(displayed),
        //                 value: _.slugify(displayed),
        //                 name: displayed            
        //               }
        //             })
        //             console.log(rez)
        //             callback(rez);
        //           }
        //       });
        //     } else {
        //       console.log("kboom2");
        //       callback();
        //     }  
        //   }
        // };
        // $('.c-geoselect--region').selectize(region_options);
      
        // var region_options = {        
        //   valueField: 'name',
        //   labelField: 'name',
        //   searchField: 'name',
        //   options: [],
        //   create: false,
        //   load: function(query, callback) {
        //     if (!query.length) return callback();
        //     $.get({
        //         url: 'https://api-adresse.data.gouv.fr/search/',
        //         type: 'GET',
        //         dataType: 'json',
        //         data: {
        //           q: query,
        //           type: "municipality"
        //         },
        //         error: function() {
        //             callback();
        //         },
        //         success: function(res) {
        //           callback([]);
        //           var uniq_context = _.uniqBy(res.features, function(e) {
        //             return e.properties.context
        //           });
        //           var rez = _.map(uniq_context, function(e){
        //             var displayed = e.properties.context
        //             return {
        //               value: _.slugify(displayed),
        //               name: displayed            
        //             }
        //           })
        //           callback(rez);
        //         }
        //     });
        //   }
        // };
        // $('.c-geoselect--region').selectize(region_options);



        var town_options = {        
          valueField: 'name',
          labelField: 'name',
          searchField: 'name',
          options: [],
          create: false,
          load: function(query, callback) {
            if (!query.length) return callback();
            $.get({
                url: 'https://api-adresse.data.gouv.fr/search/',
                type: 'GET',
                dataType: 'json',
                data: {
                  q: query,
                  type: "municipality"
                },
                error: function() {
                    callback();
                },
                success: function(res) {
                  callback([]);
                  var uniq_citycode = _.uniqBy(res.features, function(e) {
                    return e.properties.citycode
                  });
                  var rez = _.map(uniq_citycode, function(e){
                    var displayed = e.properties.label + " " + e.properties.postcode
                    return {
                      value: _.slugify(displayed),
                      name: displayed            
                    }
                  })
                  callback(rez);
                }
            });
          }
        };
        $('.c-geoselect--town').selectize(town_options);


      
    }

});

