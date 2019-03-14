class ListVariablesOfRule

  def initialize
    @activated_models = ActivatedModelsService.instance
  end

  def call(rule_id)
    child_rule_ids = FindChildRules.new.call(rule_id)
    only_simple_rules = _reject_composite_rules(child_rule_ids)
    variable_ids = only_simple_rules.map { |simple| simple["variable_id"]  }
    @activated_models.variables.select{|v| variable_ids.include?(v["id"])}
  end

  def _reject_composite_rules(rules_id)
    found_rules = @activated_models.rules.select{|r| rules_id.include?(r["id"])}
    found_rules.select{|r| r["slave_rules"].blank?}
  end

end
