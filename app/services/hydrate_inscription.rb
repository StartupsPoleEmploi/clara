class HydrateInscription

  def call(asker_attributes)
    h = asker_attributes.with_indifferent_access
    if h[:v_duree_d_inscription] != "non_inscrit"
      h[:v_inscrit] = "oui"
    else
      h[:v_inscrit] = "non"
    end
    h
  end

end


# {
#                   "v_handicap" => "non",
#                  "v_spectacle" => "oui",
#                      "v_cadre" => "non",
#                    "v_diplome" => "niveau_1",
#                   "v_category" => nil,
#        "v_duree_d_inscription" => "non_inscrit",
#       "v_allocation_value_min" => "43",
#            "v_allocation_type" => "ASS_AER_APS_AS-FNE",
#                        "v_qpv" => nil,
#                        "v_zrr" => nil,
#                        "v_age" => "54",
#             "v_location_label" => nil,
#             "v_location_route" => nil,
#              "v_location_city" => nil,
#           "v_location_country" => nil,
#           "v_location_zipcode" => nil,
#          "v_location_citycode" => "44047",
#     "v_location_street_number" => nil,
#             "v_location_state" => nil
# }
