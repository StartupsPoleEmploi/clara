clara.js_define("admin_geowhere", {

    please_if: function() {
      return $(".c-geowhere").exists();
    },

    please: function() {

        var department_options = {        
          placeholder: "",
          options: [
            {value: "ain", name: "Ain" },
            {value: "loire-atlantique", name: "Loire-Atlantique" },
          ],
          labelField: 'name',
          searchField: ['name'],
        };
        $('.c-geoselect--department').selectize(department_options);

        var region_options = {        
          placeholder: "",
          options: [
            {value: "bretagne", name: "Bretagne" },
            {value: "ara", name: "Auvergne-Rhone-Alpes" },
          ],
          labelField: 'name',
          searchField: ['name'],
        };
        $('.c-geoselect--region').selectize(region_options);
      
        var town_options = {        
          // placeholder: "",
          // // options: [
          // //   {value: "nantes", name: "Nantes" },
          // //   {value: "rennes", name: "Rennes" },
          // // ],
          // labelField: 'name',
          // searchField: ['name'],
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
                  console.log(res);
                  var uniq_citycode = _.uniqBy(res.features, function(e) {
                    return e.properties.citycode
                  });
                  var rez = _.map(uniq_citycode, function(e){
                    town_postcode = e.properties.label + " " + e.properties.postcode
                    return {
                      value: _.slugify(town_postcode),
                      name: town_postcode            
                    }
                  })
                  console.log(rez);
                    // callback([
                    //   {value: "nantes", name: "Nantes" },
                    //   {value: "rennes", name: "Rennes" },
                    // ]);
                  callback(rez);
                }
            });
          }
        };
        $('.c-geoselect--town').selectize(town_options);


      
    }

});

