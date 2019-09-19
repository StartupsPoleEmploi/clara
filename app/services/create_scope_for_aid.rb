class CreateScopeForAid

  def call(h)
    trundle = h[:trundle]
    aid = h[:aid]
    geo = h[:geo]

    if _has_at_least_one_valid_rule(trundle)
      ap "has at least one valid rule"
      uuid = _create_uuid
      rules_no_geo = _create_rules_no_geo(trundle, uuid)
      root_rule_no_geo = rules_no_geo[0]
      root_rule_with_geo = _create_geo(root_rule_no_geo, geo, uuid)
      aid.rule = root_rule_with_geo
      aid.save
    else
      ap "no valid rule"
    end


  end

  def _create_geo(root_rule_no_geo, geo, uuid)
    
    res = root_rule_no_geo

    selection = geo[:selection]
    towns     = geo[:town]
    deps      = geo[:dep]
    regions   = geo[:region]

    return res if selection == "tout"
    return res if (towns.blank? && deps.blank? && regions.blank?) && selection == "rien_sauf"
    return res if (towns.blank? && deps.blank? && regions.blank?) && selection == "tout_sauf"

    rule_geo = nil

    if selection == "rien_sauf"
      rule_geo = CreateRienSauf.new.call(uuid, towns, deps, regions)
    elsif selection == "tout_sauf"
      rule_geo = CreateToutSauf.new.call(uuid, towns, deps, regions)
    elsif selection == "domtom_seulement"
      rule_geo = CreateRienSaufDomTom.new.call(uuid)
    elsif selection == "tout_sauf_domtom"
      rule_geo = CreateToutSaufDomTom.new.call(uuid)
    end  

    Rule.new(
      name: "r_#{uuid}_box_all", 
      kind: "composite", 
      composition_type: "and_rule",
      slave_rules: [root_rule_no_geo, rule_geo]
    )

  end

  def _create_uuid
    ('a'..'z').to_a.shuffle[0,16].join
  end

  def _has_at_least_one_valid_rule(root_obj)
    all_valid = []
    is_valid = -> (obj, _p, _i) do 
      all_valid.push(_is_simple_rule(obj) || _is_complex_rule(obj))
    end
    _parse(root_obj, is_valid)
    all_valid.any?
  end

  def _create_rules_no_geo(obj, uuid)

    all_rules = []

    create_rule = -> (obj, _p, _i) do 
      ap obj[:name]
      kind = _is_simple_rule(obj) ? "simple" : _is_complex_rule(obj) ? "composite" : nil
      composition_type = obj[:subcombination] == "AND" ? :and_rule : obj[:subcombination] == "OR" ? :or_rule : nil
      slave_rules_descr = ""
      obj[:subboxes].each do |subbox|
        slave_rules_descr += "r_#{uuid}_#{subbox[:name]},"
      end

      activated = ActivatedModelsService.instance
      variable_id = activated.variables.detect{ |var| var["name"] ==  obj[:xvar] }.try(:[], "id")
      operator_kind = obj[:xop]
      value_eligible = obj[:xval]
      description = obj[:xtxt]

      if !!kind
        all_rules.push(
          Rule.new(
            name: "r_#{uuid}_#{obj[:name]}",
            kind: kind,
            composition_type: composition_type,
            description: description,
            variable_id: variable_id,
            operator_kind: operator_kind,
            value_eligible: value_eligible,
            simulated: slave_rules_descr, # hack, simulated field is used as temp value
          )
        )
      end
    end

    _parse(obj, create_rule)

    all_rules.each do |one_rule|
      if !one_rule.simulated.blank?
        one_rule.simulated.split(",").each do |subrule_name|
          if subrule_name.size > 1
            actual_subrule = all_rules.detect { |e| e.name == subrule_name }
            one_rule.slave_rules.push(actual_subrule)
          end
        end
        one_rule.simulated = nil
      end
    end

    all_rules

  end





  def _is_simple_rule(box)
    !box[:xvar].blank? && !box[:xop].blank?  && !box[:xval].blank?
  end

  def _is_complex_rule(box)
    (box[:subcombination] == "AND" || box[:subcombination] == "OR") && box[:subboxes].size > 0
  end

  def _parse(obj, callback, _parent=nil, _index=nil)
    callback.call(obj, _parent, _index)
    if obj[:subboxes] && obj[:subboxes].size > 0
      obj[:subboxes].each_with_index do |subbox, x|
        _parse(subbox, callback, obj, x)
      end
    end
  end

  def _remove_currently_editing_rules(obj)
    array_of_candidates = []
    track_editing = -> (obj, _p, _i) do 
      ap obj[:is_editing]
      obj[:is_editing] ? array_of_candidates.push({parent: _p, elt: obj}) : nil
    end
    _parse(obj, track_editing, nil, nil)
    array_of_candidates
  end


end
# l = -> (obj, _p, _i) { puts "Merci #{obj[:name]}" }

## !! delete every currently editing rule

## a first filter : composite (subcombination filled, and at least one subbox) or simple (xval, xop, xvar filled)


# {
#      "selection" => "rien_sauf",
#           "town" => {
#         "0" => {
#             "88383" => "Remiremont 88"
#         },
#         "1" => {
#             "21577" => "Saint-Usage 21"
#         }
#     },
#     "department" => {
#         "val" => [
#             [0] "01",
#             [1] "04"
#         ],
#         "txt" => [
#             [0] "01 Ain",
#             [1] "04 Alpes-de-Haute-Provence"
#         ]
#     },
#         "region" => {
#         "val" => [
#             [0] "BFC"
#         ],
#         "txt" => [
#             [0] "Bourgogne-Franche-Comté"
#         ]
#     }
# }


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
