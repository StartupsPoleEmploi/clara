clara.js_define("admin_geowhere", {

    please_if: function() {
      return $(".c-geowhere").exists();
    },

    please: function() {

        $("input#tout").prop("checked", true);

        var department_options = {        
          valueField: 'name',
          labelField: 'name',
          searchField: 'name',
          options: [
                    {value:"01", name:"01 Ain"},
                    {value:"02", name:"02 Aisne"},
                    {value:"03", name:"03 Allier"},
                    {value:"04", name:"04 Alpes-de-Haute-Provence"},
                    {value:"05", name:"05 Hautes-Alpes"},
                    {value:"06", name:"06 Alpes-Maritimes"},
                    {value:"07", name:"07 Ardèche"},
                    {value:"08", name:"08 Ardennes"},
                    {value:"09", name:"09 Ariège"},
                    {value:"10", name:"10 Aube"},
                    {value:"11", name:"11 Aude"},
                    {value:"12", name:"12 Aveyron"},
                    {value:"13", name:"13 Bouches-du-Rhône"},
                    {value:"14", name:"14 Calvados"},
                    {value:"15", name:"15 Cantal"},
                    {value:"16", name:"16 Charente"},
                    {value:"17", name:"17 Charente-Maritime"},
                    {value:"18", name:"18 Cher"},
                    {value:"19", name:"19 Corrèze"},
                    {value:"2A", name:"2A Corse-du-Sud"},
                    {value:"2B", name:"2B Haute-Corse"},
                    {value:"21", name:"21 Côte-d'Or"},
                    {value:"22", name:"22 Côtes-d'Armor"},
                    {value:"23", name:"23 Creuse"},
                    {value:"24", name:"24 Dordogne"},
                    {value:"25", name:"25 Doubs"},
                    {value:"26", name:"26 Drôme"},
                    {value:"27", name:"27 Eure"},
                    {value:"28", name:"28 Eure-et-Loir"},
                    {value:"29", name:"29 Finistère"},
                    {value:"30", name:"30 Gard"},
                    {value:"31", name:"31 Haute-Garonne"},
                    {value:"32", name:"32 Gers"},
                    {value:"33", name:"33 Gironde"},
                    {value:"34", name:"34 Hérault"},
                    {value:"35", name:"35 Ille-et-Vilaine"},
                    {value:"36", name:"36 Indre"},
                    {value:"37", name:"37 Indre-et-Loire"},
                    {value:"38", name:"38 Isère"},
                    {value:"39", name:"39 Jura"},
                    {value:"40", name:"40 Landes"},
                    {value:"41", name:"41 Loir-et-Cher"},
                    {value:"42", name:"42 Loire"},
                    {value:"43", name:"43 Haute-Loire"},
                    {value:"44", name:"44 Loire-Atlantique"},
                    {value:"45", name:"45 Loiret"},
                    {value:"46", name:"46 Lot"},
                    {value:"47", name:"47 Lot-et-Garonne"},
                    {value:"48", name:"48 Lozère"},
                    {value:"49", name:"49 Maine-et-Loire"},
                    {value:"50", name:"50 Manche"},
                    {value:"51", name:"51 Marne"},
                    {value:"52", name:"52 Haute-Marne"},
                    {value:"53", name:"53 Mayenne"},
                    {value:"54", name:"54 Meurthe-et-Moselle"},
                    {value:"55", name:"55 Meuse"},
                    {value:"56", name:"56 Morbihan"},
                    {value:"57", name:"57 Moselle"},
                    {value:"58", name:"58 Nièvre"},
                    {value:"59", name:"59 Nord"},
                    {value:"60", name:"60 Oise"},
                    {value:"61", name:"61 Orne"},
                    {value:"62", name:"62 Pas-de-Calais"},
                    {value:"63", name:"63 Puy-de-Dôme"},
                    {value:"64", name:"64 Pyrénées-Atlantiques"},
                    {value:"65", name:"65 Hautes-Pyrénées"},
                    {value:"66", name:"66 Pyrénées-Orientales"},
                    {value:"67", name:"67 Bas-Rhin"},
                    {value:"68", name:"68 Haut-Rhin"},
                    {value:"69", name:"69 Rhône"},
                    {value:"70", name:"70 Haute-Saône"},
                    {value:"71", name:"71 Saône-et-Loire"},
                    {value:"72", name:"72 Sarthe"},
                    {value:"73", name:"73 Savoie"},
                    {value:"74", name:"74 Haute-Savoie"},
                    {value:"75", name:"75 Paris"},
                    {value:"76", name:"76 Seine-Maritime"},
                    {value:"77", name:"77 Seine-et-Marne"},
                    {value:"78", name:"78 Yvelines"},
                    {value:"79", name:"79 Deux-Sèvres"},
                    {value:"80", name:"80 Somme"},
                    {value:"81", name:"81 Tarn"},
                    {value:"82", name:"82 Tarn-et-Garonne"},
                    {value:"83", name:"83 Var"},
                    {value:"84", name:"84 Vaucluse"},
                    {value:"85", name:"85 Vendée"},
                    {value:"86", name:"86 Vienne"},
                    {value:"87", name:"87 Haute-Vienne"},
                    {value:"88", name:"88 Vosges"},
                    {value:"89", name:"89 Yonne"},
                    {value:"90", name:"90 Territoire de Belfort"},
                    {value:"91", name:"91 Essonne"},
                    {value:"92", name:"92 Hauts-de-Seine"},
                    {value:"93", name:"93 Seine-Saint-Denis"},
                    {value:"94", name:"94 Val-de-Marne"},
                    {value:"95", name:"95 Val-d'Oise"},
                    {value:"971", name:"971 Guadeloupe"},
                    {value:"972", name:"972 Martinique"},
                    {value:"973", name:"973 Guyane"},
                    {value:"974", name:"974 Réunion"},
                    {value:"976", name:"976 Mayotte"},
                    {value:"975", name:"975 Saint-Pierre-et-Miquelon"},
                    {value:"988", name:"988 Nouvelle Calédonie"},
                    {value:"987", name:"987 Polynésie française"},
                    {value:"986", name:"986 Wallis-et-Futuna"},
                  ],
        };
        $('.c-geoselect--department').selectize(department_options);





        var region_options = {        
          valueField: 'name',
          labelField: 'name',
          searchField: 'name',
          options: [
            {value:"ARA", name:"Auvergne-Rhône-Alpes"},
            {value:"BFC", name:"Bourgogne-Franche-Comté"},
            {value:"BRE", name:"Bretagne"},
            {value:"CVL", name:"Centre-Val de Loire"},
            {value:"COR", name:"Corse"},
            {value:"GES", name:"Grand Est"},
            {value:"HDF", name:"Hauts-de-France"},
            {value:"IDF", name:"Île-de-France"},
            {value:"NOR", name:"Normandie"},
            {value:"NAQ", name:"Nouvelle-Aquitaine"},
            {value:"OCC", name:"Occitanie"},
            {value:"PDL", name:"Pays de la Loire"},
            {value:"PAC", name:"Provence-Alpes-Côte d'Azur"},
          ],
        };
        $('.c-geoselect--region').selectize(region_options);






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
                    var displayed = e.properties.label + " " + e.properties.postcode.substring(0,2);
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


        var show_hide_function = function(e) {

          var targeted = e && e.currentTarget && e.currentTarget.id ? e.currentTarget.id : ""

          if (targeted === "tout_sauf") {
            $(".c-geowhere-selection").show()
            $($(".c-geowhere-selections").detach()).appendTo(".c-geowhere-line.is-tout_sauf");
          } else if (targeted === "rien_sauf") {
            $(".c-geowhere-selection").show()
            $($(".c-geowhere-selections").detach()).appendTo(".c-geowhere-line.is-rien_sauf");
          } else {
            $(".c-geowhere-selection").hide()
          }
        };


        $("input[type='radio']").on("click", show_hide_function);

        show_hide_function(null);
      
    }

});

