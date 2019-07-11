require "test_helper"

class ResultDefaultTest < ActiveSupport::TestCase
  
  test '.displayed_filters reject empty filters' do
    #given
    args = nominal_args
    sut = ResultDefault.new(nil, args)
    filters = args['flat_all_filter']
    #when
    res = sut.displayed_filters
    #then
    assert_equal(11, filters.size)
    assert_equal(10, res.size)
  end

  test '.displayed_filters sort them by ordre_affichage' do
    #given
    args = nominal_args
    sut = ResultDefault.new(nil, args)
    filters = args['flat_all_filter']
    filters_cleaned = filters.reject{|e| e["ordre_affichage"] == nil}
    order = Proc.new { |e| e['ordre_affichage']  }
    #when
    res = sut.displayed_filters
    #then
    assert_equal(false, ascending?(filters_cleaned.map(&order))
    assert_equal(true, ascending?(res.map(&order)))
  end

  def nominal_args
    {"flat_all_eligible"=>
      [{"id"=>106,
        "name"=>"Mobilize ",
        "slug"=>"mobilize",
        "short_description"=>
         "Les Garages Renault Solidaires (GRS) proposent l'entretien ou la Location avec Option d'Achat à petit prix pour les publics en situation précaire",
        "ordre_affichage"=>10,
        "contract_type_id"=>1,
        "filters"=>[{"id"=>2, "slug"=>"se-deplacer"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"eligible"},
       {"id"=>72,
        "name"=>"Parcours Emploi Compétences ",
        "slug"=>"parcours-emploi-competences",
        "short_description"=>
         "Le Parcours Emploi Compétences  (PEC) remplace les contrats aidés : il est destiné aux publics en difficulté d'insertion",
        "ordre_affichage"=>0,
        "contract_type_id"=>5,
        "filters"=>[{"id"=>8, "slug"=>"s-informer-sur-contrats-specifiques"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"eligible"},
       {"id"=>84,
        "name"=>"Insertion par l'activité économique (IAE)",
        "slug"=>"insertion-par-l-activite-economique-iae",
        "short_description"=>
         "Accompagnement dans l'emploi pour les personnes très éloignées de l'emploi",
        "ordre_affichage"=>17,
        "contract_type_id"=>6,
        "filters"=>[{"id"=>4, "slug"=>"accompagne-recherche-emploi"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"eligible"},
       {"id"=>59,
        "name"=>"Validation des acquis professionnels (VAP)",
        "slug"=>"validation-des-acquis-professionnels-vap",
        "short_description"=>
         "Dispositif permettant de suivre une formation supérieure sans avoir obtenu les diplômes requis pour y accéder ",
        "ordre_affichage"=>72,
        "contract_type_id"=>8,
        "filters"=>[{"id"=>10, "slug"=>"se-former-valoriser-ses-competences"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"eligible"}],
     "flat_all_uncertain"=>
      [{"id"=>169,
        "name"=>"Programme solidaire Mana Ara",
        "slug"=>"programme-solidaire-mana-ara",
        "short_description"=>"Programme d'aide à la mobilité solidaire",
        "ordre_affichage"=>6,
        "contract_type_id"=>1,
        "filters"=>[{"id"=>4, "slug"=>"accompagne-recherche-emploi"}],
        "custom_filters"=>[],
        "need_filters"=>[{"id"=>7, "slug"=>"acceder-a-un-moyen-de-transport"}],
        "eligibility"=>"uncertain"},
       {"id"=>110,
        "name"=>
         "Aide au déplacement en train ou bus dans la région Hauts de France",
        "slug"=>"aide-au-deplacement-en-train-dans-la-region-hauts-de-france",
        "short_description"=>
         "Le Conseil régional des Hauts de France propose aux demandeurs d'emploi une prise en charge totale ou partielle du prix du billet de train et/ou bus pour un déplacement",
        "ordre_affichage"=>13,
        "contract_type_id"=>1,
        "filters"=>[{"id"=>2, "slug"=>"se-deplacer"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"uncertain"},
       ],
     "flat_all_ineligible"=>
      [{"id"=>146,
        "name"=>"Près de chez vous : Sphère Emploi Tarbes Pyrénées",
        "slug"=>"pres-de-chez-vous-sphere-emploi-tarbes-pyrenees",
        "short_description"=>
         "Communauté d'entraide réservée aux personnes qui exercent une activité à temps partiel",
        "ordre_affichage"=>1,
        "contract_type_id"=>6,
        "filters"=>[{"id"=>12, "slug"=>"pres_de_chez_vous"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"ineligible"},
       {"id"=>104,
        "name"=>"Programme de formation professionnelle - CTM",
        "slug"=>"programme-de-formation-professionnelle-ctm",
        "short_description"=>
         "Programme de formation pour aider les demandeurs d'emploi de Martinique à suivre des formations qualifiantes ou professionnalisantes",
        "ordre_affichage"=>5,
        "contract_type_id"=>10,
        "filters"=>[{"id"=>10, "slug"=>"se-former-valoriser-ses-competences"}],
        "custom_filters"=>[],
        "need_filters"=>[],
        "eligibility"=>"ineligible"}],
     "flat_all_contract"=>
      [{"id"=>6,
        "name"=>"Appui à l'embauche",
        "created_at"=>"2017-08-31T12:23:10.984Z",
        "updated_at"=>"2018-07-13T11:59:37.553Z",
        "ordre_affichage"=>4,
        "icon"=>
         "<svg></svg>",
        "slug"=>"appui-a-l-embauche",
        "category"=>"aide",
        "plural"=>"Appuis à l'embauche"},
       {"id"=>1,
        "name"=>"Aide à la mobilité",
        "created_at"=>"2017-08-29T08:24:42.442Z",
        "updated_at"=>"2018-07-13T12:00:25.885Z",
        "ordre_affichage"=>0,
        "icon"=>
         "<svg></svg>",
        "slug"=>"aide-a-la-mobilite",
        "category"=>"aide",
        "plural"=>"Aides à la mobilité"},
       {"id"=>4,
        "name"=>
         "Aide à la définition du projet professionnel, à l'orientation, ou à la reconversion",
        "created_at"=>"2017-08-29T08:30:59.713Z",
        "updated_at"=>"2019-03-29T07:20:36.023Z",
        "ordre_affichage"=>1,
        "icon"=>
         "<svg></svg>",
        "slug"=>"aide-a-la-definition-du-projet-professionnel",
        "category"=>"dispositif",
        "plural"=>
         "Aides à la définition du projet professionnel, à l'orientation, ou à la reconversion"},
       {"id"=>8,
        "name"=>"Dispositif de formation, certification, obtention de diplôme",
        "created_at"=>"2017-09-22T15:13:13.099Z",
        "updated_at"=>"2019-03-29T06:41:31.887Z",
        "ordre_affichage"=>7,
        "icon"=>
         "<svg></svg>",
        "slug"=>"dispositif-de-conversion-d-experience-en-titre",
        "category"=>"dispositif",
        "plural"=>
         "Dispositifs de  formation, certification, obtention de diplôme"},
       {"id"=>3,
        "name"=>"Emploi international",
        "created_at"=>"2017-08-29T08:27:40.467Z",
        "updated_at"=>"2018-07-13T12:01:49.308Z",
        "ordre_affichage"=>6,
        "icon"=>
         "<svg></svg>",
        "slug"=>"emploi-international",
        "category"=>"aide",
        "plural"=>"Emplois internationaux"},
       {"id"=>5,
        "name"=>"Contrat spécifique",
        "created_at"=>"2017-08-29T09:21:18.821Z",
        "updated_at"=>"2018-07-13T12:03:01.846Z",
        "ordre_affichage"=>5,
        "icon"=>
         "<svg></svg>",
        "slug"=>"contrat-specifique",
        "category"=>"dispositif",
        "plural"=>"Contrats spécifiques"},
       {"id"=>9,
        "name"=>"Dispositif Séniors",
        "created_at"=>"2017-10-19T11:46:08.744Z",
        "updated_at"=>"2018-07-13T12:04:48.976Z",
        "ordre_affichage"=>8,
        "icon"=>
         "<svg> </svg>",
        "slug"=>"dispositif-seniors",
        "category"=>"dispositif",
        "plural"=>"Dispositifs Séniors"},
       {"id"=>2,
        "name"=>"Aide à la création ou reprise d'entreprise",
        "created_at"=>"2017-08-29T08:25:23.430Z",
        "updated_at"=>"2018-07-13T12:00:57.826Z",
        "ordre_affichage"=>3,
        "icon"=>
         "<svg></svg>",
        "slug"=>"aide-a-la-creation-ou-reprise-d-entreprise",
        "category"=>"aide",
        "plural"=>"Aides à la création ou reprise d'entreprise"},
       {"id"=>7,
        "name"=>"Contrat en alternance",
        "created_at"=>"2017-09-05T07:17:45.949Z",
        "updated_at"=>"2018-07-13T12:03:37.037Z",
        "ordre_affichage"=>2,
        "icon"=>
         "<svg></svg>",
        "slug"=>"contrat-en-alternance",
        "category"=>"dispositif",
        "plural"=>"Contrats en alternance"},
       {"id"=>10,
        "name"=>"Aide régionale",
        "created_at"=>"2017-11-27T09:54:01.154Z",
        "updated_at"=>"2018-07-13T12:05:29.393Z",
        "ordre_affichage"=>100,
        "icon"=>
         "<svg></svg>",
        "slug"=>"aide-regionale",
        "category"=>"aide",
        "plural"=>"Aides régionales"}],
     "flat_all_filter"=>
      [{"id"=>12,
        "name"=>"Près de chez vous",
        "description"=>"Près de chez vous",
        "slug"=>"pres_de_chez_vous",
        "ordre_affichage"=>nil},
       {"id"=>8,
        "name"=>"S'informer sur les contrats spécifiques",
        "description"=>"S'informer sur les contrats spécifiques",
        "slug"=>"s-informer-sur-contrats-specifiques",
        "ordre_affichage"=>1},
       {"id"=>7,
        "name"=>"Travailler en Europe ou à l'international",
        "description"=>"Travailler en Europe ou à l'international",
        "slug"=>"travailler-a-l-international",
        "ordre_affichage"=>2},
       {"id"=>3,
        "name"=>"Faire garder son enfant",
        "description"=>"Faire garder son enfant",
        "slug"=>"garder-enfant",
        "ordre_affichage"=>3},
       {"id"=>6,
        "name"=>"Créer ou reprendre une entreprise",
        "description"=>"Créer ou reprendre une entreprise",
        "slug"=>"creer-entreprise",
        "ordre_affichage"=>4},
       {"id"=>5,
        "name"=>"Trouver un métier, changer de métier",
        "description"=>"Trouver un métier, changer de métier",
        "slug"=>"trouver-change-de-metier",
        "ordre_affichage"=>6},
       {"id"=>2,
        "name"=>"Se déplacer",
        "description"=>"Se déplacer",
        "slug"=>"se-deplacer",
        "ordre_affichage"=>7},
       {"id"=>11,
        "name"=>"Connaître les aides au bénéfice des employeurs",
        "description"=>"Connaître les aides au bénéfice des employeurs",
        "slug"=>"aides-employeurs",
        "ordre_affichage"=>8},
       {"id"=>10,
        "name"=>"Financer une formation, obtenir un diplôme",
        "description"=>"Financer une formation, obtenir un diplôme",
        "slug"=>"se-former-valoriser-ses-competences",
        "ordre_affichage"=>9},
       {"id"=>4,
        "name"=>"Être accompagné·e pour la recherche d'emploi",
        "description"=>"Être accompagné·e pour la recherche d'emploi",
        "slug"=>"accompagne-recherche-emploi",
        "ordre_affichage"=>5},
       {"id"=>9,
        "name"=>"Travailler en alternance",
        "description"=>"eee",
        "slug"=>"travailler-en-alternance",
        "ordre_affichage"=>0}],
     "asker"=>
      {"v_handicap"=>"non",
       "v_spectacle"=>"oui",
       "v_cadre"=>"non",
       "v_diplome"=>"niveau_2",
       "v_category"=>nil,
       "v_duree_d_inscription"=>"non_inscrit",
       "v_allocation_value_min"=>"not_applicable",
       "v_allocation_type"=>"RSA",
       "v_qpv"=>nil,
       "v_zrr"=>nil,
       "v_age"=>"34",
       "v_location_label"=>nil,
       "v_location_route"=>nil,
       "v_location_city"=>nil,
       "v_location_country"=>nil,
       "v_location_zipcode"=>nil,
       "v_location_citycode"=>"",
       "v_location_street_number"=>nil,
       "v_location_state"=>nil}
    }
  end
    
end
