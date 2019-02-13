variable_list = [
  ["v_age",                       true, :integer, ""],
  ["v_allocation_type",           true, :selectionnable, "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise"],
  ["v_allocation_value_min",      true, :integer, ""],
  ["v_category",                  true, :selectionnable, "cat_12345,autres_cat"],
  ["v_diplome",                   true, :selectionnable, "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5"],
  ["v_duree_d_inscription",       true, :selectionnable, "plus_d_un_an,moins_d_un_an,non_inscrit"],
  ["v_harki",                     true, :selectionnable, "oui,non"],
  ["v_protection_internationale", true, :selectionnable, "oui,non"],
  ["v_handicap",                  true, :selectionnable, "oui,non"],
  ["v_spectacle",                 true, :selectionnable, "oui,non"],
  ["v_cadre",                     true, :selectionnable, "oui,non"],
  ["v_location_city",             false, :string, ""],
  ["v_location_citycode",         true, :string, ""],
  ["v_location_country",          false, :string, ""],
  ["v_location_label",            false, :string, ""],
  ["v_location_route",            false, :string, ""],
  ["v_location_state",            true, :string, ""],
  ["v_location_street_number",    false, :string, ""],
  ["v_location_zipcode",          true, :string, ""],
  ["v_zrr",                       true, :selectionnable, "oui,non"],
  ["v_qpv",                       true, :selectionnable, "oui,non"],
]

existing_variables = Variable.all.map(&:name)

named_variables = Variable.all.group_by(&:name).transform_values{|e| e[0]}

variable_list.each do |name_arg, visibility_arg, type_arg, elements_arg|
  unless named_variables.keys.include?(name_arg)
    Variable.create!(name: name_arg, is_visible: visibility_arg, variable_type: type_arg, elements: description_arg)
  end
end


explicitation_list = [
  ["e_age_more_than", 
      named_variables["v_age"], 
      :more_than, 
      nil, 
      "Être âgé de XX ans ou plus"],
  ["e_age_equal", 
      named_variables["v_age"], 
      :equal, 
      nil, 
      "Être âgé de XX ans"],
  ["e_allocation_type_equal_ass", 
      named_variables["v_allocation_type"], 
      :equal, 
      "ASS_AER_APS_AS-FNE", 
      "Être bénéficiaire de l'ASS, l'AER, l'APS, ou l'AS-FNE"],
  ["e_allocation_type_equal_pas_indemnise", 
    named_variables["v_allocation_type"],  
    :equal, 
    "pas_indemnise", 
    "Ne recevoir aucune allocation"],
]
existing_explicitations = Explicitation.all.map(&:name)

explicitation_list.each do |name_arg, variable_arg, operator_kind_arg, value_eligible_arg, template_arg|
  unless existing_explicitations.include?(name_arg)
    Explicitation.create!(
      name: name_arg, 
      variable: variable_arg, 
      operator_kind: operator_kind_arg, 
      value_eligible: value_eligible_arg, 
      template: template_arg
    )
  end
end


