
##################################################################
# Variables
##################################################################

variable_list = [
  ["v_age",                      
    "âge", 
    :integer, 
    ""],
  ["v_allocation_type",
    "type d'allocation", 
    :selectionnable, 
    "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise"],
  ["v_allocation_value_min",
    "montant min de l'allocation", 
    :integer, 
    ""],
  ["v_category",
     "catégorie", 
     :selectionnable, 
     "cat_12345,autres_cat", 
     "catégorie 1;2;3;4;ou 5,autres catégories"],
  ["v_diplome",                  
    "diplôme",                     
    :selectionnable, 
    "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5"],
  ["v_duree_d_inscription",      
    "durée d'inscription",         
    :selectionnable, 
    "plus_d_un_an,moins_d_un_an,non_inscrit", 
    "plus d'un an,moins d'un an,non inscrit"],
  ["v_protection_internationale",
    "protection internationale",   
    :selectionnable, 
    "oui,non"],
  ["v_handicap",                 
    "handicappé",                  
    :selectionnable, 
    "oui,non"],
  ["v_spectacle",                
    "intermittent du spectacle",   
    :selectionnable, 
    "oui,non"],
  ["v_cadre",                    
    "statut cadre",                
    :selectionnable, 
    "oui,non"],
  ["v_location_citycode",        
    "geo : code INSEE ville",      
    :string,         
    ""],
  ["v_location_zipcode",         
    "geo : code postal",           
    :string,         
    ""],
  ["v_zrr",                      
    "zone rurale prioritaire",     
    :selectionnable, 
    "oui,non"]
]

existing_variables = Variable.all.map(&:name)

variable_list.each do |name_arg, name_trans_arg, type_arg, elements_arg, elts_trans_arg|
  unless existing_variables.include?(name_arg)
    Variable.create!(
      name: name_arg, 
      name_translation: name_trans_arg, 
      variable_type: type_arg, 
      elements: elements_arg,
      elements_translation: elts_trans_arg
      )
  end
end





# ##################################################################
# # Rules
# ##################################################################

rule_list = [
  {
     kind: "simple",
     name: "r_AREASP",
     variable: Variable.find_by(name:"v_allocation_type"),
     operator_kind: :equal,
     value_eligible: "ARE_ASP",
     description: "Être indemnisé/e au titre de l'allocation de retour à l'emploi"
  },
  {
     kind: "simple",
     name: "r_deld",
     variable: Variable.find_by(name:"v_duree_d_inscription"),
     operator_kind: :equal,
     value_eligible: "plus_d_un_an",
     description: "Être inscrit depuis 1 an ou plus"
  },
  {
     kind: "simple",
     name: "r_diplome_niveau_4",
     variable: Variable.find_by(name: "v_diplome"),
     operator_kind: :equal,
     value_eligible: "niveau_4",
  },
  {
     kind: "simple",
     name: "r_diplome_niveau_5",
     variable: Variable.find_by(name: "v_diplome"),
     operator_kind: :equal,
     value_eligible: "niveau_5",
  },
  {
     kind: "simple",
     name: "r_diplome_infra_5",
     variable: Variable.find_by(name: "v_diplome"),
     operator_kind: :equal,
     value_eligible: "niveau_infra_5",
     description: "Être inscrit depuis 1 an ou plus"
  },
  {
     kind: "simple",
     name: "r_age_inf_28",
     variable: Variable.find_by(name: "v_age"),
     value_eligible: "28",
     operator_kind: :less_than,
     description: "Avoir moins de 28 ans"
  },
  {
     kind: "simple",
     name: "r_age_sup_18",
     variable: Variable.find_by(name: "v_age"),
     value_eligible: "18",
     operator_kind: :more_than,
     description: "Avoir plus de 18 ans"
  },
  {
     kind: "composite",
     name: "r_diplome_4_ou_5_ou_infra_5",
     composition_type: :or_rule,
     slave_rules: [ "r_diplome_niveau_4", 
                   "r_diplome_niveau_5", 
                   "r_diplome_infra_5"],
  },
  {
     kind: "composite",
     name: "r_age_sup_18_et_age_inf_28_et_deld",
     description: "Avoir entre 18 et 28 ans et être inscrit/e à Pôle emploi depuis plus de 12 mois dans les 18 derniers mois",
     composition_type: :and_rule,
     slave_rules: [ "r_age_sup_18", 
                   "r_age_inf_28", 
                   "r_deld"],
  },
  {
     kind: "composite",
     name: "r_age_sup_18_et_age_inf_28_et_diplome_inf_niveau_3",
     description: "Avoir entre 18 et 28 ans et un diplôme inférieur au 1er cycle de l'enseignement supérieur",
     composition_type: :and_rule,
     slave_rules: [ "r_age_sup_18", 
                   "r_age_inf_28", 
                   "r_diplome_4_ou_5_ou_infra_5"],
  },
  {
     kind: "composite",
     name: "r_CIVIS",
     composition_type: :and_rule,
     slave_rules: [ "r_age_sup_18_et_age_inf_28_et_deld", 
                   "r_age_sup_18_et_age_inf_28_et_diplome_inf_niveau_3"],

  },
  {
     kind: "composite",
     name: "r_VI",
     composition_type: :and_rule,
     slave_rules: [ "r_age_sup_18", 
                   "r_age_inf_28"],
  },
]

existing_rules = Rule.all.map(&:name)

rule_list.each do |rule_attributes|
  unless existing_rules.include?(rule_attributes[:name])
    new_rule = Rule.new(rule_attributes.except(:slave_rules))
    if rule_attributes[:slave_rules]
      new_rule.slave_rules = rule_attributes[:slave_rules].map { |slave_rule_name|  Rule.find_by(name: slave_rule_name)  }
    end
    new_rule.save!
  end
end





##################################################################
# Contracts
##################################################################

contract_list = [
  {
     name: "Emploi international",
     plural: "Emplois internationaux",
     slug: "emploi-international",
     description: "Emploi(s) en Europe ou à l'international",
     ordre_affichage: 6,
     icon: "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 100 100\"><title>ic-mission-international</title><g id=\"Calque_19\" data-name=\"Calque 19\"><path d=\"M51,72A22,22,0,1,1,61.92,30.9a1.16,1.16,0,0,1-1.15,2,19.69,19.69,0,1,0,9.29,22,1.16,1.16,0,0,1,2.24.58A22,22,0,0,1,51,72Z\"/><path d=\"M58,58.18c-.32-1.52-1.67-2.27-3-3a9.32,9.32,0,0,1-2-1.37c-3.47-3.47-6.1-2.92-6.9-2.63a4.5,4.5,0,0,0-2.26,1.06c-1-.33-3.23-2-3.23-3.4a1.16,1.16,0,0,0-1.52-1.1c-.52.17-.95.18-1.11,0a.82.82,0,0,1-.07-.78.62.62,0,0,1,.5-.45c.26,0,2,0,3.05,0h1.47c2,0,3.47-3,3.47-4.63a12.11,12.11,0,0,0-.08-1.31,3.35,3.35,0,0,1,0-.51s.12-.21.8-.72c2.27-1.7,3-2.22,2.71-3.22s-1.06-1-1.61-1.1a3.58,3.58,0,0,1-2.13-.9c-.69-.69-1.51-1.35-2.44-1.07a2,2,0,0,0-1.19,1.79l0,.09c-.73,0-1.24-.29-1.93-1.67a1.16,1.16,0,1,0-2.07,1c1.36,2.73,2.91,3,4.51,3a1.68,1.68,0,0,0,1.64-1.36A5.12,5.12,0,0,0,46.35,37l-.68.51c-1.61,1.21-1.83,1.89-1.69,3.32a9.69,9.69,0,0,1,.07,1.08,3.89,3.89,0,0,1-1.16,2.32H41.44c-2.22,0-3,0-3.3,0a2.9,2.9,0,0,0-2.45,2,3.25,3.25,0,0,0-.09,1.89,2.2,2.2,0,0,1-.81-.39h0c0-1.48-1.86-3.49-2.66-4.29L30.5,45a8.85,8.85,0,0,1,2,2.66c0,1.14.83,3.06,6.33,3.08a8.45,8.45,0,0,0,3.64,3.4,9.77,9.77,0,0,0-.71,3.94,1.15,1.15,0,0,0,.06.37,15.44,15.44,0,0,0,1.9,3.69,6.85,6.85,0,0,1,1.52,4,7.45,7.45,0,0,0,.88,4,1.16,1.16,0,1,0,2-1.14,5.13,5.13,0,0,1-.58-2.9,9,9,0,0,0-1.89-5.31,13.82,13.82,0,0,1-1.58-3c.06-4.21,2.1-4.43,2.31-4.44a1.4,1.4,0,0,0,.48-.11c.07,0,1.74-.67,4.49,2.08a11.17,11.17,0,0,0,2.54,1.76c.89.5,1.73,1,1.83,1.46.05.26,0,.89-1,2.22a12.63,12.63,0,0,1-2.92,2.92c-1.46,1.09-2.32,1.88-3.08,5.66a1.16,1.16,0,0,0,.91,1.36l.23,0A1.16,1.16,0,0,0,51,69.91c.62-3.08,1.11-3.45,2.19-4.25a14.84,14.84,0,0,0,3.39-3.38C57.77,60.66,58.22,59.36,58,58.18Z\"/><path d=\"M63.73,55.8h0c-.65,0-6.32-3.06-9.37-7.16-2-2.74-2.67-5.51-1.87-8.23,1.18-4,4.3-5.46,6.62-5.46a6.88,6.88,0,0,1,4.63,1.78,6.87,6.87,0,0,1,4.63-1.78c2.31,0,5.43,1.43,6.62,5.46,1.05,3.57.13,9.07-10.25,15l-.28.16A1.15,1.15,0,0,1,63.73,55.8ZM59.1,37.26c-1.58,0-3.57,1-4.39,3.8C53,47,61.5,52.11,63.69,53.31c7-4,10.21-8.35,9.07-12.25-.82-2.8-2.81-3.8-4.39-3.8a4.63,4.63,0,0,0-3.68,1.83,1.23,1.23,0,0,1-.95.49h0a1.23,1.23,0,0,1-.95-.49A4.65,4.65,0,0,0,59.1,37.26Z\"/></g></svg>",
     category: "aide",
  },
  {
     name: "Appui à l'embauche",
     plural: "Appuis à l'embauche",
     slug: "appui-a-l-embauche",
     description: "Aide(s) pour la reprise d'un emploi",
     ordre_affichage: 4,
     icon: "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 100 100\"><title>ic-reprise-emploi</title><g id=\"Calque_33\" data-name=\"Calque 33\"><path d=\"M78.87,65.12H68.65a1.13,1.13,0,0,0-1.13,1.13v5.67h-2.9a4.5,4.5,0,0,0,.63-2.27V60.58a4.53,4.53,0,0,0-2-3.78l-8.92-5.95L56.38,44l2.69,3.77a3.4,3.4,0,0,0,2.77,1.42h9.08a3.4,3.4,0,0,0,0-6.8H63.6L58.94,35.9a3.42,3.42,0,0,0-1-.94,6.8,6.8,0,1,0-7.72-1.37l-1.49-.21a3.18,3.18,0,0,0-.48,0,3.37,3.37,0,0,0-1.81.52l-9.07,5.67a3.37,3.37,0,0,0-1.24,1.37L31.57,50a3.37,3.37,0,0,0-.36,1.52c0,.06,0,.12,0,.18l-4-2.3a1.13,1.13,0,0,0-1.55.42l-4.54,7.86a1.14,1.14,0,0,0,.41,1.55L33.36,66a1.14,1.14,0,0,0,.86.12,1.14,1.14,0,0,0,.69-.53l4.54-7.86A1.14,1.14,0,0,0,39,56.19l-2.88-1.66A3.38,3.38,0,0,0,37.66,53l0-.05,4.08-8.16,3.17-2L42.77,50a5.57,5.57,0,0,0-.19,1.3,1.32,1.32,0,0,0,0,.23V65.28l-4.15,9.33a4.49,4.49,0,0,0,.23,4.11h-9.7a1.13,1.13,0,0,0,0,2.27H57.31a1.13,1.13,0,0,0,1.14-1.13V74.19H68.65a1.13,1.13,0,0,0,1.13-1.13V67.38h9.08a1.13,1.13,0,1,0,0-2.27ZM33.51,63.48l-9.83-5.67,3.4-5.9,9.82,5.67ZM55,24.27a4.54,4.54,0,1,1-4.54,4.54A4.54,4.54,0,0,1,55,24.27ZM40.48,75.54,44.73,66l.1-.46V51.58a1.16,1.16,0,0,0,0-.12,3.57,3.57,0,0,1,.11-.86l3-10a1.13,1.13,0,0,0-1.69-1.29l-6,3.75a1.13,1.13,0,0,0-.41.46L35.63,52l0,0a1.14,1.14,0,0,1-1,.59,1.18,1.18,0,0,1-.51-.12,1.13,1.13,0,0,1-.63-1,1.11,1.11,0,0,1,.12-.5l4.54-9.08a1.08,1.08,0,0,1,.41-.45l9.08-5.67a1.12,1.12,0,0,1,.6-.18h.15l8,1.13a1.12,1.12,0,0,1,.76.47l5,7a1.12,1.12,0,0,0,.92.47h7.91a1.14,1.14,0,0,1,0,2.27H61.85a1.12,1.12,0,0,1-.93-.48l-4-5.64a1.13,1.13,0,0,0-2,.33L51.9,51a1.13,1.13,0,0,0,.46,1.27L62,58.69a2.27,2.27,0,0,1,1,1.89v9.08a2.27,2.27,0,0,1-2.25,2.27h0a2.27,2.27,0,0,1-2.26-2.27V62.39a1.13,1.13,0,0,0-.51-.94l-6.8-4.54a1.13,1.13,0,0,0-1.76.94v8.39a2.28,2.28,0,0,1-.19.92L44.63,77.38a2.27,2.27,0,0,1-2.08,1.35,2.22,2.22,0,0,1-.92-.2,2.27,2.27,0,0,1-1.35-2.08A2.2,2.2,0,0,1,40.48,75.54Zm15.69-2.49v5.68h-9.7a4.48,4.48,0,0,0,.23-.43l4.54-10.21a4.53,4.53,0,0,0,.39-1.84V60l4.54,3v6.65A4.5,4.5,0,0,0,56.86,72a1.11,1.11,0,0,0-.68,1Z\"/></g></svg>",
     category: "aide",
  }
]


existing_contracts = ContractType.all.map(&:slug)

contract_list.each do |contract|
  unless existing_contracts.include?(contract[:slug])
    ContractType.create!(contract)
  end
end


##################################################################
# Aids
##################################################################

aid_list = [
  {
     name: "Contrat d'insertion dans la vie sociale (CIVIS)",
     what:"<p>Le CIVIS est sign&eacute; avec la <a href=\"http://www.mission-locale.fr/\" target=\"_blank\" rel=\"noopener\">mission locale</a> ou la permanence d'Accueil d'Information et d'Orientation (PAIO) qui d&eacute;signe un conseiller r&eacute;f&eacute;rent.</p>\r\n<p>Ce conseiller va vous accompagner pour r&eacute;aliser votre projet d'insertion au travers de diverses actions : entretiens, ateliers collectifs, mises en situation professionnelle, propositions d'emploi, de stage, de formation, ...</p>\r\n<p>Le CIVIS est conclu pour une dur&eacute;e d'un an.</p>",
     short_description: "Accompagnement vers l'accès à un emploi durable",
     how_much: "<p>Une aide financi&egrave;re peut &ecirc;tre propos&eacute;e si vous ne percevez aucune r&eacute;mun&eacute;ration au titre d'un emploi ou d'un stage, ni d'autres allocations.</p>\r\n<p>Elle est vers&eacute;e chaque mois et peut &ecirc;tre suspendue ou supprim&eacute;e en cas de non respect des engagements au titre du CIVIS.</p>\r\n<p>Son montant varie selon votre situation personnelle et votre projet d'insertion, et dans la limite maximum de 15 euros sur 1 jour, 450 euros sur 1 mois et 1800 euros sur 1 an.</p>",
     additionnal_conditions: "<p>Le CIVIS b&eacute;n&eacute;ficie notamment aux personnes dont le niveau de qualification est inf&eacute;rieur ou &eacute;quivalent bac g&eacute;n&eacute;ral mais il existe des d&eacute;rogations possibles si vous n'avez pas achev&eacute; le premier cycle de l'enseignement sup&eacute;rieur et que vous rencontrez des difficult&eacute;s particuli&egrave;res d'insertion.</p>",
     how_and_when: "<p>Pour b&eacute;n&eacute;ficier du CIVIS, contactez la <a href=\"http://www.mission-locale.fr/\" target=\"_blank\" rel=\"noopener\">mission locale</a> ou la PAIO dont vous d&eacute;pendez.</p>",
     limitations: "",
     ordre_affichage: 42,
     archived_at: Date.new(2018),
     contract_type: ContractType.find_by(slug: "appui-a-l-embauche"),
     rule: Rule.find_by(name: "r_CIVIS"),
  },
  {
     name: "Volontariat international (VI)",
     what: "<p>La mission peut &ecirc;tre effectu&eacute;e en VIE (volontariat international en entreprise) ou en VIA (volontariat international en administration), au sein de diff&eacute;rentes structures (ambassades, universit&eacute;s et laboratoires, centres culturels, organisations non gouvernementales, ...).</p>\r\n\r\n<p>Il existe des missions tr&egrave;s vari&eacute;es :</p>\r\n\r\n<ul>\r\n\t<li>pour le VIE elles concernent principalement les domaines informatique, marketing, finance, contr&ocirc;le de gestion, promotion et assistance technique, commerce et industrie</li>\r\n\t<li>pour le VIA, il s&#39;agit de missions propos&eacute;es par les services d&#39;Etat &agrave; l&#39;&eacute;tranger : animateurs culturels, attach&eacute;s de presse, m&eacute;decins, cuisiniers, architectes, informaticiens, attach&eacute;s de coop&eacute;ration culturelle ou scientifique, graphistes, ...</li>\r\n</ul>\r\n\r\n<p>La mission peut durer de 6 &agrave; 24 mois* et permet de participer au rayonnement &eacute;conomique, culturel et scientifique de la France &agrave; l&#39;&eacute;tranger.</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     short_description: "Mission rémunérée qui permet d'avoir une première expérience à l'international",
     how_much: "<p>Vous percevez une indemnit&eacute; d&#39;un montant pouvant aller de 1432 euros &agrave; 4784 euros nets.**</p>\r\n\r\n<p>Les frais de voyage et de transport de bagages aller/retour sont pris en charge.</p>\r\n\r\n<p>Pendant toute la dur&eacute;e de la mission, vous b&eacute;n&eacute;ficiez d&#39;une couverture sociale et d&#39;un suivi.</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     additionnal_conditions: "<p>Vous devez &nbsp;:</p>\r\n\r\n<ul>\r\n\t<li>&ecirc;tre de nationalit&eacute; fran&ccedil;aise ou ressortissant(e) d&#39;un pays de l&#39;espace &eacute;conomique europ&eacute;en (EEE)</li>\r\n\t<li>&ecirc;tre en r&egrave;gle avec les obligations de service national du pays dont vous &ecirc;tes ressortissant(e)</li>\r\n\t<li>jouir de vos droits civiques et avoir un casier judiciaire vierge</li>\r\n</ul>\r\n\r\n<p>Vous ne pouvez r&eacute;aliser qu&#39;une seule mission de volontariat international.</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     how_and_when: "<p>Vous devez enregistrer votre candidature par internet sur le site <a href=\"http://www.civiweb.com\" rel=\"noopener\" target=\"_blank\">Civiweb</a>.</p>\r\n\r\n<p>Une confirmation &eacute;crite d&#39;inscription vous parvient dans les 30 jours suivants.</p>\r\n\r\n<p>Par la suite, vous pouvez effectuer des recherches de missions en consultant r&eacute;guli&egrave;rement les offres du site CIVI et/ou en contactant directement les entreprises fran&ccedil;aises exportatrices et les administrations potentielles.</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     limitations: "<p>* La dur&eacute;e moyenne observ&eacute;e est de 17 mois.</p>\r\n\r\n<p>** L&#39;indemnit&eacute; est fix&eacute;e par d&eacute;cret et varie selon le pays d&#39;affectation.</p>\r\n\r\n<p>Voir toutes les opportunit&eacute;s sur le <a href=\"http://www.decouvrirlemonde.jeunes.gouv.fr/\" target=\"_blank\">portail gouvernemental pour la mobilit&eacute; des jeunes.</a></p>\r\n",
     ordre_affichage: 63,
     archived_at: nil,
     contract_type: ContractType.find_by(slug: "emploi-international"),
     rule: Rule.find_by(name: "r_VI"),
  },
  {
     name: "Aide incitative à la reprise d'emploi (activité salariée)",
     what: "<p>Cette aide permet de cumuler l'Allocation d'aide au retour &agrave; l'emploi (ARE) &nbsp;avec une r&eacute;mun&eacute;ration (activit&eacute; professionnelle salari&eacute;e exerc&eacute;e en France ou &agrave; l'&eacute;tranger).</p>\r\n<p>Cette aide est vers&eacute;e lorsque vous reprenez un emploi et que le salaire est inf&eacute;rieur &agrave; votre allocation ch&ocirc;mage.</p>",
     short_description: "Cumul d'une partie de l'allocation chômage avec votre salaire",
     how_much: "<p>Vous allez cumuler votre salaire avec une partie de votre allocation mensuelle.</p>\r\n<p>La partie de cette allocation est &eacute;gale &agrave; votre allocation pr&eacute;c&eacute;dente totale moins 70% de la r&eacute;mun&eacute;ration brute que vous percevez au titre de votre reprise d'emploi.</p>\r\n<p>Le montant d'allocation re&ccedil;u lorsque vous travaillez est donc inf&eacute;rieur &agrave; celui que vous receviez sans travailler. Ce diff&eacute;rentiel est converti en jours et permet de prolonger la dur&eacute;e de vos droits.</p>\r\n<p>Vous pouvez calculer le montant approximatif du compl&eacute;ment gr&acirc;ce &agrave; un <a href=\"https://candidat.pole-emploi.fr/candidat/simucalcul/repriseemploi\" target=\"_blank\" rel=\"noopener\">outil de simulation</a>.</p>",
     additionnal_conditions: "<p>Pour un mois donn&eacute;, le total (ARE + salaire) ne doit pas d&eacute;passer le montant du salaire brut que vous perceviez ant&eacute;rieurement.</p>",
     how_and_when: "<p>Lorsque vous reprenez une activit&eacute; professionnelle, vous devez informer P&ocirc;le emploi au moment de votre actualisation.</p>\r\n<p>Lorsque vous allez vous actualiser sur pole-emploi.fr ou par t&eacute;l&eacute;phone, vous allez d&eacute;clarer le nombre d'heures travaill&eacute;es dans le mois ainsi que le montant du salaire brut per&ccedil;u (ou une estimation si vous n'avez pas encore re&ccedil;u votre bulletin de paie).&nbsp;</p>\r\n<p>D&egrave;s que vous avez votre bulletin de paie, scannez-le depuis votre espace personnel <a href=\"http://www.pole-emploi.fr/accueil/\" target=\"_blank\" rel=\"noopener\">pole-emploi.fr</a>.</p>\r\n<p>Le calcul du compl&eacute;ment se fera automatiquement.</p>",
     limitations: "<p>Le cumul des allocations et des r&eacute;mun&eacute;rations ne peut exc&eacute;der le montant mensuel du salaire de r&eacute;f&eacute;rence.</p>",
     ordre_affichage: 41,
     archived_at: nil,
     contract_type: ContractType.find_by(slug: "appui-a-l-embauche"),
     rule: Rule.find_by(name: "r_AREASP"),
  },
  {
     name: "Volontariat de solidarité internationale (VSI)",
     what: "<p>Vous vous engagez comme volontaire dans des associations qui ont pour objet des actions de solidarit&eacute; internationale dans le domaine de l&#39;enseignement, du d&eacute;veloppement, du d&eacute;veloppement rural, de la sant&eacute; (parfois pour des actions d&#39;urgences).</p>\r\n\r\n<p>Par exemple (liste non exhaustive) &nbsp;:&nbsp;Action Contre la Faim,&nbsp;ATD Quart Monde,&nbsp;Croix Rouge fran&ccedil;aise, Handicap international, M&eacute;decins du monde, Plan&egrave;te enfants, ...*</p>\r\n\r\n<p>La mission dure entre 6 mois et 2 ans.**</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     short_description: "Missions effectuées en dehors de l'espace économique européen et au sein d'associations agréées",
     how_much: "<p>Le montant minimum de votre indemnisation est de 100 euros par mois, hors prise en charge du logement, du transport et de la nourriture.***</p>\r\n\r\n<p>Vous &ecirc;tes affili&eacute; &agrave; un r&eacute;gime de s&eacute;curit&eacute; sociale qui couvre la maladie, la maternit&eacute;, l&#39;invalidit&eacute;, le d&eacute;c&egrave;s, l&#39;accident du travail et maladies professionnelles.&nbsp;</p>\r\n\r\n<p>L&#39;association prend en charge pour vous et vos ayants droit une assurance maladie compl&eacute;mentaire, une assurance responsabilit&eacute; civile et une assurance rapatriement sanitaire.</p>\r\n\r\n<p>En fin de mission, vous pouvez b&eacute;n&eacute;ficier de :</p>\r\n\r\n<ul>\r\n\t<li>la prime d&#39;insertion professionnelle si vous &ecirc;tes inscrit/e comme demandeur d&#39;emploi et que vous ne remplissez pas les conditions pour avoir le RSA. Cette prime est d&#39;un montant de &nbsp;2001 euros maximum, vers&eacute;e tous les 3 mois pendant 9 mois maximum</li>\r\n\t<li>l&#39;indemnit&eacute; de r&eacute;installation si vous avez effectu&eacute; au moins 24 mois de mission en continu. Son montant est de 3700 euros.</li>\r\n</ul>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     additionnal_conditions: "<p>Vous devez accomplir votre mission en dehors du pays dont vous &ecirc;tes ressortissant/e ou r&eacute;sident/e.</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     how_and_when: "<p>Pour trouver une mission, vous pouvez contacter directement les associations agr&eacute;es pour le VSI ou vous rendre sur la <a href=\"http://www.france-volontaires.org\" rel=\"noopener\" target=\"_blank\">plateforme France volontaires.</a></p>\r\n\r\n<p>Ensuite, vous signez un contrat de VSI avec l&#39;association qui vous forme et prend en charge les frais de voyages li&eacute;s &agrave; votre mission.</p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     limitations: "<p>* <a href=\"http://www.diplomatie.gouv.fr/IMG/pdf/liste_associations_agreees_2016_cle419424.pdf\" rel=\"noopener\" target=\"_blank\">Liste compl&egrave;te</a></p>\r\n\r\n<p>** La dur&eacute;e cumul&eacute;e des diff&eacute;rentes missions ne peut pas exc&eacute;der 6 ans.</p>\r\n\r\n<p>*** Il ne s&#39;agit pas d&#39;un salaire : il n&#39;y a donc pas d&#39;imposition sur le revenu et pas de pr&eacute;l&egrave;vement au titre des contributions et cotisations sociales.</p>\r\n\r\n<p>Voir toutes les opportunit&eacute;s sur le <a href=\"http://www.decouvrirlemonde.jeunes.gouv.fr/\" target=\"_blank\">portail gouvernemental pour la mobilit&eacute; des jeunes.</a></p>\r\n\r\n<div id=\"sconnect-is-installed\" style=\"display: none;\">2.5.0.0</div>\r\n",
     rule: Rule.find_by(name: "r_age_sup_18"),
     ordre_affichage: 64,
     contract_type: ContractType.find_by(slug: "emploi-international"),
     archived_at: nil,
  },
]

existing_aids = Aid.all.map(&:slug)

aid_list.each do |aid_attributes|
  unless existing_aids.include?(aid_attributes[:slug])
    Aid.new(aid_attributes).save
  end
end

##################################################################
# Zrrs
##################################################################

zrr_list = [
  "02004", # Agnicourt
  "49490", # Noyant-Villages
  "71520", # StPierreleVieux
]
Zrr.destroy_all
Zrr.new(value: zrr_list.join(",")).save
