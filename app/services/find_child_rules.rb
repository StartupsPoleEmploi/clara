class FindChildRules

  def call(rule_id)
    res = []
    

    activated_models = ActivatedModelsService.instance
    all_rules = activated_models.rules

    # rule_exist_in_cache = !!all_rules.find{|r| rule_id == r["id"]}
    rule_exist_in_cache = false

    if (rule_exist_in_cache)
      _fill_rules_array(rule_id, res, all_rules)
    else
      db_rule = Rule.find(rule_id)
      is_simple = !!db_rule.variable
      if is_simple
        res = [rule_id]
      else
        root_rules_id = db_rule.slave_rules.map { |e| e.id }
        root_rules_id.each do |root_rule|
          _fill_rules_array(root_rule, res, all_rules)
        end
      end
    end

    res
  end


  def _fill_rules_array(rule_id, array_to_fill, all_rules)
    return if array_to_fill.include?(rule_id) 
    array_to_fill << rule_id
    current_rule = all_rules.find{|r| rule_id == r["id"]}

    if current_rule && current_rule["slave_rules"].size > 0
      current_rule["slave_rules"].each do |slave_rule|
        _fill_rules_array(slave_rule["id"], array_to_fill, all_rules)
      end
    end
  end

end
