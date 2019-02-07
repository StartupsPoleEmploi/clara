variable_list = [
  ["v_age",                       :integer, ""],
  ["v_allocation_type",           :selectionnable, "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise"],
  ["v_allocation_value_min",      :integer, ""],
  ["v_category",                  :selectionnable, "cat_12345,autres_cat"],
  ["v_diplome",                   :selectionnable, "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5"],
  ["v_duree_d_inscription",       :selectionnable, "plus_d_un_an,moins_d_un_an,non_inscrit"],
  ["v_harki",                     :selectionnable, "oui,non"],
  ["v_protection_internationale", :selectionnable, "oui,non"],
  ["v_handicap",                  :selectionnable, "oui,non"],
  ["v_spectacle",                 :selectionnable, "oui,non"],
  ["v_cadre",                     :selectionnable, "oui,non"],
  ["v_location_city",             :string, ""],
  ["v_location_citycode",         :string, ""],
  ["v_location_country",          :string, ""],
  ["v_location_label",            :string, ""],
  ["v_location_route",            :string, ""],
  ["v_location_state",            :string, ""],
  ["v_location_street_number",    :string, ""],
  ["v_location_zipcode",          :string, ""],
  ["v_zrr",                       :selectionnable, "oui,non"]
  ["v_qpv",                       :selectionnable, "oui,non"]
]

existing_variables = Variable.all.map(&:name)

variable_list.each do |name_arg, type_arg, elements_arg|
  unless existing_variables.include?(name_arg)
    Variable.create!(name: name_arg, variable_type: type_arg, elements: description_arg)
  end
end
