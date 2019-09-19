class ExtractGeoForAid

  def call(aid)
    res = {}

    if aid.is_a?(Aid) && aid.rule
      concerned_rule = nil
      if aid.rule.name.end_with?("_box_all")
        concerned_rule = aid.rule.slave_rules.detect{|r| r.name.end_with?("_box_geo")}
        res = _fill(JSON.parse(concerned_rule.slave_rules.to_json))
      end  
    end

    return res
  end

  def _fill(rules)
    h = {
        citycode: [],
        department: [],
        region: [],
    }.with_indifferent_access
    rules.each  do |r|
      key = r["name"].split("_")[2]
      h[key].push(r["name"].split("_")[-3])
    end
    h
  end

end



# {
#               "name" => "root_box",
#     "subcombination" => "AND",
#           "subboxes" => [
#         {
#                       "name" => "box_1568038992875",
#             "subcombination" => "",
#                   "subboxes" => [],
#                       "xval" => "cat_12345",
#                        "xop" => "equal",
#                       "xvar" => "v_category",
#                       "xtxt" => "Être en catégorie 1, 2, 3, 4 ou 5",
#                 "is_editing" => false
#         },
#         {
#                       "name" => "box_1568038997729",
#             "subcombination" => "OR",
#                   "subboxes" => [
#                  {
#                               "name" => "box_1568039005966b",
#                     "subcombination" => "",
#                           "subboxes" => [],
#                               "xval" => "42",
#                                "xop" => "less_than",
#                               "xvar" => "v_age",
#                               "xtxt" => "Avoir un âge strictement inférieur à 42 ans",
#                         "is_editing" => false
#                 },
#                 {
#                               "name" => "box_1568039005966a",
#                     "subcombination" => "",
#                           "subboxes" => [],
#                               "xval" => "plus_d_un_an",
#                                "xop" => "equal",
#                               "xvar" => "v_duree_d_inscription",
#                               "xtxt" => "Être inscrit depuis plus d'un an à Pôle Emploi",
#                         "is_editing" => false
#                 }
#             ],
#                       "xval" => "",
#                        "xop" => "",
#                       "xvar" => "",
#                       "xtxt" => "",
#                 "is_editing" => false
#         }
#     ]
# }
