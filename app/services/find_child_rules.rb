class FindChildRules

  def call(rule_id)
    p '- - - - - - - - - - - - - - rule_id- - - - - - - - - - - - - - - -' 
    pp rule_id
    p ''
    res = []
    

    activated_models = ActivatedModelsService.instance
    all_rules = activated_models.rules

    _fill_rules_array(rule_id, res, all_rules)

    res
  end


  def _fill_rules_array(rule_id, array_to_fill, all_rules)
    return if array_to_fill.include?(rule_id) 
    array_to_fill << rule_id
    current_rule = all_rules.find{|r| rule_id == r["id"]}

    if current_rule["slave_rules"].size > 0
      current_rule["slave_rules"].each do |slave_rule|
        _fill_rules_array(slave_rule["id"], array_to_fill, all_rules)
      end
    end
  end

end
