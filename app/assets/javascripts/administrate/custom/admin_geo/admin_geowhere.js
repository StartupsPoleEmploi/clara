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
          placeholder: "",
          options: [
            {value: "nantes", name: "Nantes" },
            {value: "rennes", name: "Rennes" },
          ],
          labelField: 'name',
          searchField: ['name'],
        };
        $('.c-geoselect--town').selectize(town_options);
      
    }

});

