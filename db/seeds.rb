variable_list = [
  {name: "v_age",                       
    variable_kind: "integer", 
    description: nil, 
    elements: nil,
    name_translation: "âge", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_duree_d_inscription",       
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "plus_d_un_an,moins_d_un_an,non_inscrit",
    name_translation: "durée d'inscription", 
    elements_translation: "plus d'un an, moins d'un an, non inscrit", 
    is_visible: true},
  {name: "v_category",                  
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "cat_12345,autres_cat",
    name_translation: "catégorie", 
    elements_translation: "1 à 5, autres catégories", 
    is_visible: true},
  {name: "v_diplome",                   
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "niveau_infra_5,niveau_5,niveau_4,niveau_3,niveau_2,niveau_1",
    name_translation: "diplôme", 
    elements_translation: "bac +4 et +, bac +3, bac +1 et +2 (BTS/DUT), Bac, CAP/BEP, aucun diplôme", 
    is_visible: true},
  {name: "v_allocation_value_min",      
    variable_kind: "integer", 
    description: nil, 
    elements: nil,
    name_translation: "montant minimum d'allocation", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_qpv",                       
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est en QPV", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_handicap",                  
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est en situation de handicap", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_protection_internationale", 
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est bénéficiaire d'une protection internationale", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_detenu",                    
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est détenu ou ancien détenu", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_harki",                     
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est descendant de harki", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_city",             
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : nom de la ville", 
    elements_translation: nil, 
    is_visible: false},
  {name: "v_location_citycode",         
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : code INSEE de la ville", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_country",          
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : pays", 
    elements_translation: nil, 
    is_visible: false},
  {name: "v_location_route",            
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : nom de la rue", 
    elements_translation: nil, 
    is_visible: false},
  {name: "v_location_state",            
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : région", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_zipcode",          
    variable_kind: "string", 
    description: nil, 
    elements: nil,
    name_translation: "geo : code postal", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_spectacle",                 
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est intermittent du spectacle", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_allocation_type",           
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise",
    name_translation: "type d'allocation", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_zrr",                       
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est en ZRR", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_cadre",                     
    variable_kind: "selectionnable", 
    description: nil, 
    elements: "oui,non",
    name_translation: "est un cadre", 
    elements_translation: nil, 
    is_visible: true},
  {name: "v_location_label",            
    variable_kind: "string", 
    description: "",
    elements: "",
    name_translation: "est un cadre", 
    elements_translation: "",
    is_visible: false},
  {name: "v_location_street_number",    
    variable_kind: "string", 
    description: "",
    elements: "",
    name_translation: "geo : numéro de voie", 
    elements_translation: "",
    is_visible: false},
]

# First time creation
named_variables = Variable.all.group_by(&:name).transform_values{|e| e[0]}

variable_list.each do |v_attributes|
  v_name = v_attributes[:name]
  unless named_variables.keys.include?(v_name)
    named_variables[v_name] = Variable.create!(v_attributes)
  end
end

explicitation_list = [
  ["v_duree_d_inscription", 
      :equal, 
      "non_inscrit", 
      "Ne pas être inscrit à Pôle Emploi"],
  ["v_duree_d_inscription", 
      :equal, 
      "moins_d_un_an", 
      "Être inscrit depuis moins d'un an à Pôle Emploi"],
  ["v_duree_d_inscription", 
      :equal, 
      "plus_d_un_an", 
      "Être inscrit depuis plus d'un an à Pôle Emploi"],
  ["v_category", 
      :equal, 
      "cat_12345", 
      "Être en catégorie 1, 2, 3, 4 ou 5"],
  ["v_category", 
      :equal, 
      "autres_cat", 
      "Être en catégorie autre que 1, 2, 3, 4 ou 5"],
  ["v_allocation_type", 
      :equal, 
      "ARE_ASP", 
      "Être bénéficiaire de l'ARE ou de l'ASP"],
  ["v_allocation_type", 
      :equal, 
      "ASS_AER_APS_AS-FNE", 
      "Être bénéficiaire de l'ASS, l'AER, l'APS, ou l'AS-FNE"],
  ["v_allocation_type", 
      :equal, 
      "RPS_RFPA_RFF_pensionretraite", 
      "Être bénéficiaire du RPS, du RFPA, du RFF, ou percevoir une pension de retraite"],
  ["v_allocation_type", 
      :equal, 
      "RSA", 
      "Être bénéficiaire du RSA"],
  ["v_allocation_type", 
      :equal, 
      "AAH", 
      "Être bénéficiaire de l'AAH"],
  ["v_allocation_type",
    :equal, 
    "pas_indemnise", 
    "Ne recevoir aucune allocation"],
  ["v_allocation_type", 
      :not_equal, 
      "ARE_ASP", 
      "Ne pas être bénéficiaire de l'ARE ou de l'ASP"],
  ["v_allocation_type", 
      :not_equal, 
      "ASS_AER_APS_AS-FNE", 
      "Ne pas être bénéficiaire de l'ASS, l'AER, l'APS, ou l'AS-FNE"],
  ["v_allocation_type", 
      :not_equal, 
      "RPS_RFPA_RFF_pensionretraite", 
      "Ne pas être bénéficiaire du RPS, du RFPA, du RFF, ou percevoir une pension de retraite"],
  ["v_allocation_type", 
      :not_equal, 
      "RSA", 
      "Ne pas être bénéficiaire du RSA"],
  ["v_allocation_type", 
      :not_equal, 
      "AAH", 
      "Ne pas être bénéficiaire de l'AAH"],
  ["v_allocation_type",
    :not_equal, 
    "pas_indemnise", 
    "Recevoir une allocation"],
  ["v_allocation_value_min",
    :equal, 
    nil, 
    "Recevoir une allocation égale à XX euros"],
  ["v_allocation_value_min",
    :more_than, 
    nil, 
    "Recevoir une allocation strictement supérieure à XX euros"],
  ["v_allocation_value_min",
    :more_or_equal_than, 
    nil, 
    "Recevoir une allocation supérieure ou égale à XX euros"],
  ["v_allocation_value_min",
    :less_than, 
    nil, 
    "Recevoir une allocation strictement inférieure à XX euros"],
  ["v_allocation_value_min",
    :less_or_equal_than, 
    nil, 
    "Recevoir une allocation inférieure ou égale à XX euros"],
  ["v_age", 
      :equal, 
      nil, 
      "Être âgé de XX ans"],
  ["v_age", 
      :more_than, 
      nil, 
      "Avoir un âge strictement supérieur à XX ans"],
  ["v_age", 
      :more_or_equal_than, 
      nil, 
      "Avoir un âge supérieur ou égal à XX ans"],
  ["v_age", 
      :less_than, 
      nil, 
      "Avoir un âge strictement inférieur à XX ans"],
  ["v_age", 
      :less_or_equal_than, 
      nil, 
      "Avoir un âge inférieur ou égal à XX ans"],
  ["v_diplome", 
      :equal, 
      "niveau_1", 
      "Avoir un Bac +4 et + (Master) / diplômes d’ingénieur"],
  ["v_diplome", 
      :equal, 
      "niveau_2", 
      "Avoir un Bac +3 (Licence)"],
  ["v_diplome", 
      :equal, 
      "niveau_3", 
      "Avoir Bac +1 à bac +2 (BTS / DUT)"],
  ["v_diplome", 
      :equal, 
      "niveau_4", 
      "Avoir le Bac"],
  ["v_diplome", 
      :equal, 
      "niveau_5", 
      "Avoir un CAP / BEP"],
  ["v_diplome", 
      :equal, 
      "niveau_infra_5", 
      "N'avoir aucun diplôme"],
  ["v_diplome", 
      :more_than, 
      "niveau_infra_5", 
      "Avoir au moins un diplôme"],
  ["v_diplome", 
      :more_than, 
      "niveau_5", 
      "Avoir au moins le bac"],
  ["v_diplome", 
      :more_than, 
      "niveau_4", 
      "Avoir au moins bac +1"],
  ["v_diplome", 
      :more_than, 
      "niveau_3", 
      "Avoir au moins bac +3"],
  ["v_diplome", 
      :more_than, 
      "niveau_2", 
      "Avoir au moins bac +4"],
  ["v_diplome", 
      :more_than, 
      "niveau_1", 
      "Avoir plus qu'un bac + 5"],
  ["v_diplome", 
      :more_or_equal_than, 
      "niveau_infra_5", 
      "Avoir un diplôme, ou aucun"],
  ["v_diplome", 
      :more_or_equal_than, 
      "niveau_5", 
      "Avoir au moins un CAP/BEP"],
  ["v_diplome", 
      :more_or_equal_than, 
      "niveau_4", 
      "Avoir au moins le bac"],
  ["v_diplome", 
      :more_or_equal_than, 
      "niveau_3", 
      "Avoir au moins bac +1"],
  ["v_diplome", 
      :more_or_equal_than, 
      "niveau_2", 
      "Avoir au moins bac +3"],
  ["v_diplome", 
      :more_or_equal_than, 
      "niveau_1", 
      "Avoir au moins bac + 4"],
   ["v_diplome", 
      :less_than, 
      "niveau_infra_5", 
      "Impossible d'avoir moins que sans diplôme"],
  ["v_diplome", 
      :less_than, 
      "niveau_5", 
      "N'avoir aucun diplôme"],
  ["v_diplome", 
      :less_than, 
      "niveau_4", 
      "Avoir le niveau CAP/BEP, ou aucun diplôme"],
  ["v_diplome", 
      :less_than, 
      "niveau_3", 
      "Avoir le bac ou moins"],
  ["v_diplome", 
      :less_than, 
      "niveau_2", 
      "Avoir bac +2 ou moins"],
  ["v_diplome", 
      :less_than, 
      "niveau_1", 
      "Avoir bac +3 ou moins"],
  ["v_diplome", 
      :less_or_equal_than, 
      "niveau_infra_5", 
      "Ne pas avoir de diplôme, ou moins"],
  ["v_diplome", 
      :less_or_equal_than, 
      "niveau_5", 
      "Avoir le niveau CAP/BEP, ou aucun diplôme"],
  ["v_diplome", 
      :less_or_equal_than, 
      "niveau_4", 
      "Avoir le bac ou moins"],
  ["v_diplome", 
      :less_or_equal_than, 
      "niveau_3", 
      "Avoir bac +2 ou moins"],
  ["v_diplome", 
      :less_or_equal_than, 
      "niveau_2", 
      "Avoir bac +3 ou moins"],
  ["v_diplome", 
      :less_or_equal_than, 
      "niveau_1", 
      "Avoir bac +4 ou bac +5, ou moins"],     
  ["v_qpv", 
      :equal, 
      "oui", 
      "Être en Quartier Prioritaire de la Ville"],
  ["v_qpv", 
      :equal, 
      "non", 
      "Être hors Quartier Prioritaire de la Ville"],
  ["v_zrr", 
      :equal, 
      "oui", 
      "Être en Zone Rurale Prioritaire"],
  ["v_zrr", 
      :equal, 
      "non", 
      "Être hors Zone Rurale Prioritaire"],
  ["v_location_zipcode", 
      :equal, 
      nil, 
      "Avoir un code postal égal à XX"],
  ["v_location_zipcode", 
      :starts_with, 
      nil, 
      "Avoir un code postal qui commence par XX"],
  ["v_location_zipcode", 
      :not_starts_with, 
      nil, 
      "Avoir un code postal qui ne commence par XX"],
  ["v_location_zipcode", 
      :amongst, 
      nil, 
      "Avoir un code postal parmi XX"],
  ["v_location_zipcode", 
      :not_amongst, 
      nil, 
      "Avoir un code postal qui n'est pas parmi XX"],
  ["v_location_citycode", 
      :equal, 
      nil, 
      "Avoir un code ville égal à XX"],
  ["v_location_citycode", 
      :starts_with, 
      nil, 
      "Avoir un code ville qui commence par XX"],
  ["v_location_citycode", 
      :not_starts_with, 
      nil, 
      "Avoir un code ville qui ne commence par XX"],
  ["v_location_citycode", 
      :amongst, 
      nil, 
      "Avoir un code ville parmi XX"],
  ["v_location_citycode", 
      :not_amongst, 
      nil, 
      "Avoir un code ville qui n'est pas parmi XX"],
  ["v_location_state", 
      :equal, 
      nil, 
      "La Région est XX"],
  ["v_location_state", 
      :not_equal, 
      nil, 
      "La Région n'est pas XX"],
  ["v_spectacle", 
      :equal, 
      "oui", 
      "Être intermittent du spectacle"],
  ["v_spectacle", 
      :equal, 
      "non", 
      "Ne pas être intermittent du spectacle"],
  ["v_handicap", 
      :equal, 
      "oui", 
      "Être en situation de handicap"],
  ["v_handicap", 
      :equal, 
      "non", 
      "Ne pas être en situation de handicap"],
  ["v_cadre", 
      :equal, 
      "oui", 
      "Être cadre et/ou en recherche d'un poste d'encadrement"],
  ["v_cadre", 
      :equal, 
      "non", 
      "Ne pas être cadre et/ou en recherche d'un poste d'encadrement"],
  ["v_harki", 
      :equal, 
      "oui", 
      "Être harki ou descendant de harki"],
  ["v_harki", 
      :equal, 
      "non", 
      "Ne pas être harki ou descendant de harki"],
  ["v_protection_internationale", 
      :equal, 
      "oui", 
      "Être bénéficiaire d'une protection internationale"],
  ["v_protection_internationale", 
      :equal, 
      "non", 
      "Ne pas être bénéficiaire d'une protection internationale"],
]

explicitation_list.each do |variable_name_arg, operator_kind_arg, value_eligible_arg, template_arg|
  name = "e_" + variable_name_arg + "_" + operator_kind_arg.to_s + "_" + value_eligible_arg.to_s
  unless Explicitation.find_by(name: name)
    Explicitation.create!(
      name: name,
      variable: named_variables[variable_name_arg], 
      operator_kind: operator_kind_arg, 
      value_eligible: value_eligible_arg, 
      template: template_arg
    )
  end
end


