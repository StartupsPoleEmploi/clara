class ExtractGeoForAid

  def call(aid)
    res = {}

    if aid.is_a?(Aid) && aid.rule && aid.rule.name.end_with?("_box_all")
      multi_geo_rule = aid.rule.slave_rules.detect{|r| r.name.end_with?("_box_geo")}
      if multi_geo_rule
        res = _fill(JSON.parse(multi_geo_rule.slave_rules.to_json))
      else
        simple_geo_rule = aid.rule.slave_rules.detect{|r| r.name.include?("_citycode_") || r.name.include?("_department_") || r.name.include?("_region_") }
        res = _fill_simple(simple_geo_rule)
      end
    else
      res = {
        selection: "tout",
        town: [],
        department: [],
        region: [],
      }.with_indifferent_access
    end

    return res
  end

  def _extract_name(kind, rule)
    res = ""
    if (kind == "town")
      res = rule["description"].split("ésider à ")[1]
    elsif (kind == "department")
      res = rule["description"].split("le département ")[1]
    elsif (kind == "region")
      res = rule["description"].split("la région ")[1]
    end
    res
  end

  def _regions
    [
      {value:"ARA", name:"Auvergne-Rhône-Alpes"},
      {value:"BFC", name:"Bourgogne-Franche-Comté"},
      {value:"BRE", name:"Bretagne"},
      {value:"CVL", name:"Centre-Val de Loire"},
      {value:"COR", name:"Corse"},
      {value:"GES", name:"Grand Est"},
      {value:"HDF", name:"Hauts-de-France"},
      {value:"IDF", name:"Île-de-France"},
      {value:"NOR", name:"Normandie"},
      {value:"NAQ", name:"Nouvelle-Aquitaine"},
      {value:"OCC", name:"Occitanie"},
      {value:"PDL", name:"Pays de la Loire"},
      {value:"PAC", name:"Provence-Alpes-Côte d'Azur"},
    ]
  end

  def _fill_simple(rule)
    res = {
        selection: "tout",
        town: [],
        department: [],
        region: [],
    }.with_indifferent_access

    key = rule["name"].split("_")[2]
    key = "town" if key == "citycode"
    a = rule["name"].split("_")[-3]
    b = _extract_name(key, rule)
    h = {}
    h[a] = b
    res[key].push(h)

    if rule.name.include?("_not_")
      res[:selection] = "tout_sauf"
    else
      res[:selection] = "rien_sauf"
    end

    _adjust_region!(res)

    return res.with_indifferent_access
  end

  def _fill(rules)
    
    h = {
        selection: "tout",
        town: [],
        department: [],
        region: [],
    }.with_indifferent_access


    rules.each  do |r|
      added_h = {}
      key = r["name"].split("_")[2]
      key = "town" if key == "citycode"
      added_h[r["name"].split("_")[-3]] = _extract_name(key, r)
      h[key].push(added_h)
    end

    if _has_domtom_only(h) && rules.any? { |r| r["name"].include?("_not_") }
      h = {
          selection: "tout_sauf_domtom",
          town: [],
          department: [],
          region: [],
      }.with_indifferent_access
    elsif _has_domtom_only(h) && !rules.any? { |r| r["name"].include?("_not_") }
      h = {
          selection: "domtom_seulement",
          town: [],
          department: [],
          region: [],
      }.with_indifferent_access
    elsif !rules.blank? && rules.any? { |r| r["name"].include?("_not_") }
      h[:selection] = "tout_sauf"
      _adjust_region!(h)
    elsif !rules.blank? && !rules.any? { |r| r["name"].include?("_not_") }
      h[:selection] = "rien_sauf"
      _adjust_region!(h)
    end

    h

  end

  def _adjust_region!(h)
    new_region_array = []
    h[:region].each do |region|
      new_region_h = {}
      actual_region = _regions.detect{|static_region| static_region[:name] == region.values[0]}
      new_region_h[actual_region[:value]] = actual_region[:name]
      new_region_array.push(new_region_h)
    end
    h[:region] = new_region_array
  end

  def _has_domtom_only(h)
    return false unless h[:town].blank?
    return false unless h[:region].blank?
    return false if h[:department].blank?

    h[:department].map{|e| e.keys[0]}.sort == ["971", "972", "973", "974", "975", "976"]
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
