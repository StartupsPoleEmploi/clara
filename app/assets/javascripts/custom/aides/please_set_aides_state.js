clara.js_define("please_set_aides_state", {

  trigger_function: _.stubFalse,

  main_function: function(the_initial_state) {
    var that = this;
    var key = clara.please_get_state_key.main_function();
    if (_.isObject(the_initial_state) && !_.isEmpty(the_initial_state)) {
      var obj_to_store = that._extract_from_state(the_initial_state);
      store.set(key, obj_to_store);
    }
  },

  _extract_from_state: function(the_initial_state) {
    var that = this;
    console.log("the_initial_state")
    console.log(the_initial_state)
    aids_eligibles = 
      _.defaultTo(
        that._extract_ely(the_initial_state, "eligibles_zone.eligibles"),
        []
      );
    aids_ineligibles = 
      _.defaultTo(
        that._extract_ely(the_initial_state, "ineligibles_zone.ineligibles"),
        []
      );
    aids_uncertains = 
      _.defaultTo(
        that._extract_ely(the_initial_state, "uncertains_zone.uncertains"),
        []
      );

    var concatenated = _.concat(aids_eligibles, aids_uncertains, aids_ineligibles)
    var concatenated_sorted = _.sortBy(concatenated)
    return concatenated_sorted;
  },

  _extract_ely: function(an_initial_state, a_status) {
    return _.chain(an_initial_state)
              .get(a_status)
              .map(function(e){return e["aids"]})
              .flatten()
              .map(function(e){return e["name"]})
              .value();
  }

});

// {
//   "width": 1440,
//   "eligibles_zone": {
//     "eligibles": [
//       {
//         "name": "contrat-specifique",
//         "is_collapsed": false,
//         "aids": [
//           {
//             "name": "volontariat-associatif",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "s-informer-sur-contrats-specifiques",
//                 "is_collapsed": false
//               }
//             ]
//           }
//         ]
//       },
//       {
//         "name": "emploi-international",
//         "is_collapsed": true,
//         "aids": [
//           {
//             "name": "vsi-volontariat-de-solidarite-internationale",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "travailler-a-l-international",
//                 "is_collapsed": false
//               }
//             ]
//           }
//         ]
//       }
//     ]
//   },
//   "uncertains_zone": {
//     "uncertains": [
//       {
//         "name": "aide-a-la-mobilite",
//         "is_collapsed": true,
//         "aids": [
//           {
//             "name": "autres-frais-derogatoires",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "accompagne-recherche-emploi",
//                 "is_collapsed": false
//               },
//               {
//                 "name": "se-deplacer",
//                 "is_collapsed": false
//               }
//             ]
//           },
//           {
//             "name": "autres-aides-nationales-pour-la-mobilite",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "garder-enfant",
//                 "is_collapsed": false
//               },
//               {
//                 "name": "accompagne-recherche-emploi",
//                 "is_collapsed": false
//               },
//               {
//                 "name": "se-deplacer",
//                 "is_collapsed": false
//               }
//             ]
//           }
//         ]
//       },
//       {
//         "name": "emploi-international",
//         "is_collapsed": true,
//         "aids": [
//           {
//             "name": "erasmus",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "travailler-a-l-international",
//                 "is_collapsed": false
//               }
//             ]
//           }
//         ]
//       }
//     ]
//   },
//   "ineligibles_zone": {
//     "is_collapsed": false,
//     "ineligibles": [
//       {
//         "name": "aide-a-la-mobilite",
//         "is_collapsed": true,
//         "aids": [
//           {
//             "name": "aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "se-deplacer",
//                 "is_collapsed": false
//               }
//             ]
//           },
//           {
//             "name": "aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "accompagne-recherche-emploi",
//                 "is_collapsed": false
//               }
//             ]
//           }
//         ]
//       },
//       {
//         "name": "aide-a-la-definition-du-projet-professionnel",
//         "is_collapsed": true,
//         "aids": [
//           {
//             "name": "garantie-jeunes",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "accompagne-recherche-emploi",
//                 "is_collapsed": false
//               }
//             ]
//           },
//           {
//             "name": "service-militaire-volontaire-smv",
//             "is_collapsed": false,
//             "filters": [
//               {
//                 "name": "trouver-change-de-metier",
//                 "is_collapsed": false
//               },
//               {
//                 "name": "se-former-valoriser-ses-competences",
//                 "is_collapsed": false
//               }
//             ]
//           }
//         ]
//       }
//     ]
//   },
//   "filters_zone": {
//     "is_collapsed": false,
//     "filters": [
//       {
//         "name": "travailler-en-alternance",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "s-informer-sur-contrats-specifiques",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "travailler-a-l-international",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "garder-enfant",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "creer-entreprise",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "accompagne-recherche-emploi",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "trouver-change-de-metier",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "se-deplacer",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "aides-employeurs",
//         "is_checked": false,
//         "updated_at": 0
//       },
//       {
//         "name": "se-former-valoriser-ses-competences",
//         "is_checked": false,
//         "updated_at": 0
//       }
//     ]
//   },
//   "recap_zone": {
//     "is_collapsed": true
//   }
// }
