variable_list = [
  ["v_age",                       :integer, ""],
  ["v_allocation_type",           :string, "ARE_ASP,ASS_AER_APS_AS-FNE,RSA,RPS_RFPA_RFF_pensionretraite,AAH,pas_indemnise"],
  ["v_allocation_value_min",      :integer, ""],
  ["v_category",                  :string, "cat_12345,autres_cat"],
  ["v_diplome",                   :string, "niveau_1,niveau_2,niveau_3,niveau_4,niveau_5,niveau_infra_5"],
  ["v_duree_d_inscription",       :string, "plus_d_un_an,moins_d_un_an,non_inscrit"],
  ["v_harki",                     :string, "oui,non"],
  ["v_protection_internationale", :string, "oui,non"],
  ["v_handicap",                  :string, "oui,non"],
  ["v_spectacle",                 :string, "oui,non"],
  ["v_location_city",             :string, ""],
  ["v_location_citycode",         :string, ""],
  ["v_location_country",          :string, ""],
  ["v_location_label",            :string, ""],
  ["v_location_route",            :string, ""],
  ["v_location_state",            :string, ""],
  ["v_location_street_number",    :string, ""],
  ["v_location_zipcode",          :string, ""],
  ["v_qpv",                       :string, "en_qpv,hors_qpv,est_indetermine,erreur_injoignable,erreur_numero_manquant"],
  ["v_zrr",                       :string, "en_zrr,hors_zrr,erreur_technique,erreur_communication"]
]

existing_variables = Variable.all.map(&:name)

variable_list.each do |name_arg, type_arg, description_arg|
  unless existing_variables.include?(name_arg)
    Variable.create!(name: name_arg, variable_type: type_arg, description: description_arg)
  end
end
