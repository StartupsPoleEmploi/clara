variable_list = [
  ["v_age",                       "", :integer, ""],
  ["v_allocation_type",           "", :selectionnable, "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise"],
  ["v_allocation_value_min",      "", :integer, ""],
  ["v_category",                  "", :selectionnable, "cat_12345,autres_cat", "catégorie 1; ou 2; ou 3; ou 4; ou 5,autres catégories"],
  ["v_diplome",                   "", :selectionnable, "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5"],
  ["v_duree_d_inscription",       "", :selectionnable, "plus_d_un_an,moins_d_un_an,non_inscrit", "plus d'un an,moins d'un an,non inscrit"],
  ["v_protection_internationale", "", :selectionnable, "oui,non"],
  ["v_handicap",                  "", :selectionnable, "oui,non"],
  ["v_spectacle",                 "", :selectionnable, "oui,non"],
  ["v_cadre",                     "", :selectionnable, "oui,non"],
  ["v_location_citycode",         "", :string, ""],
  ["v_location_zipcode",          "", :string, ""],
  ["v_zrr",                       "", :selectionnable, "oui,non"]
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
